FROM  wordpress:4.8.0-fpm
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

ARG APT_CACHE
ENV WORDPRESS_ROOT /var/www/html

RUN set -x \
  # Optional add proxy entries for apt.
  && if [ -n "${APT_CACHE}" ]; then \
  echo Acquire::ftp::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  echo Acquire::http::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  echo Acquire::https::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  fi \
  # install tools for plugins
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y unzip wget rsync \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN set -x \
  && mkdir -p /wordpress-in \
  && mkdir -p /php-in \
  && chown www-data $WORDPRESS_ROOT

# Install plugins

ADD rootfs/install_wp_plugin.sh /usr/local/bin/install_wp_plugin.sh

RUN set -x \
  && chmod +x /usr/local/bin/install_wp_plugin.sh

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip 'e4a7c8e2d344d03007ea6ec734f08f7b5479755966bca61121f72f8197ff85bd'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-super-cache.1.4.9.zip '58e10c3cb7905fa58bc2ae1764bb1615bc1baed3cf7ba582d11bf5e8bb821766'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-piwik.1.0.15.zip '3ddc77d039619781cd51bb419d2fba68e80183672ac12af7de0a41073ddad287'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/si-contact-form.4.0.51.zip '14f535d3cc2a6c7ed9a68d6a3ff88e673e1c2679bee657365c09bbcc092e3a25'

# Finishing up.

ADD rootfs/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-in.sh

RUN set -x \
  && chmod +x /usr/local/bin/docker-entrypoint-in.sh \
  && mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-org.sh \
  && mv /usr/local/bin/docker-entrypoint-in.sh /usr/local/bin/docker-entrypoint.sh

USER www-data

WORKDIR $WORDPRESS_ROOT

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm"]
