FROM  wordpress:4.8.1-fpm
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

ARG APT_CACHE
ENV WEB_ROOT /var/www/html
ENV WEB_USER www-data

RUN set -x \
  # Optional add proxy entries for apt.
  && if [ -n "${APT_CACHE}" ]; then \
  echo Acquire::ftp::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  echo Acquire::http::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  echo Acquire::https::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  fi \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y rsync wget unzip \
  && rm -rf /var/lib/apt/lists/*

# Wordpress configuration.

# Web Root.

RUN set -x \
  && mkdir -p /wordpress-in \
  && chown www-data $WEB_ROOT

# Install plugins

ADD rootfs/install_wp_plugin.sh /usr/local/bin/install_wp_plugin.sh

RUN set -x \
  && chmod +x /usr/local/bin/install_wp_plugin.sh

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip 'e4a7c8e2d344d03007ea6ec734f08f7b5479755966bca61121f72f8197ff85bd'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-super-cache.1.5.3.zip 'b32eea5a369fdba4ff5830577429e8295036362d2e5e2e7f60cc2543773e8891'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-piwik.zip 'e0f4f2f02ee4c376a306b82757233cd7139b2cc6a1a0f2e46cae5a07c81154ac'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/si-contact-form.4.0.55.zip 'cf3d005fef0d0d87589eab7556882b606a7f1035c712c8ab94aa1a1ac9096435'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.4.2.zip 'e7ddfa9a62ff9b05de9767c2df1568136e8e63bde64843c0f31e08fc02218c75'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-optimize.2.1.1.zip 'ecb2e302e228bb9043efc01088ba297661eb6905223268afcb966161b1050761'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/the-events-calendar.4.5.10.zip 'cbe6fe9329d44d499c1077fdb2696fd729109ca6f0b4c166d3150bd418d2d5a7'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/broken-link-checker.1.11.5.zip 'd9809a17fe79d274f903267341bb82b00a1c215a2e6c161b154eecf5c381f0b3'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/add-to-any.1.7.14.zip '53bfe2a323a31e69b524bbfa4089388ec1f272020657ecb2ad9caab408297faf'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/cookie-notice.1.2.38.zip '96cda4831cd9cafe95f2a820ce46494181a28c76529e2898392958cc60ec3cd6'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/akismet.3.3.4.zip 'f5e81dc4ec37d731d190753f5090f8ca725d30e2e183aadcf86f648d7ef75d6e'

# Install themes

ADD rootfs/install_wp_theme.sh /usr/local/bin/install_wp_theme.sh

RUN set -x \
  && chmod +x /usr/local/bin/install_wp_theme.sh

# Php configuration.

ENV PHP_MAX_EXECUTION_TIME 300
ENV PHP_MEMORY_LIMIT_MB 128
ENV PHP_FPM_MAX_CHILDREN 10
ENV PHP_FPM_START_SERVERS 2
ENV PHP_FPM_MIN_SPARE_SERVERS 2
ENV PHP_FPM_MAX_SPARE_SERVERS 5
ENV PHP_FPM_MAX_REQUESTS 500
ENV PHP_FPM_REQUEST_SLOWLOG_TIMEOUT 30s
ENV PHP_FPM_CATCH_WORKERS_OUTPUT 1
ENV PHP_OPCACHE_ENABLE_CLI 1
ENV PHP_OPCACHE_ENABLE 1
ENV PHP_OPCACHE_MEMORY_CONSUMPTION_MB 128
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES 4000

RUN set -x \
  && ln -sf /dev/stdout /var/log/php-fpm-slow.log \
  && mkdir -p /php-in \
  && mkdir -p /php-fpm-in

ADD rootfs/opcache-recommended.ini /usr/local/etc/php/conf.d/zz-opcache-recommended.ini

ADD rootfs/conf.ini /usr/local/etc/php/conf.d/zz-conf.ini

ADD rootfs/www.conf /usr/local/etc/php-fpm.d/zz-www.conf

# Finishing up.

ADD rootfs/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-in.sh

RUN set -x \
  && chmod +x /usr/local/bin/docker-entrypoint-in.sh \
  && mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-org.sh \
  && mv /usr/local/bin/docker-entrypoint-in.sh /usr/local/bin/docker-entrypoint.sh

USER ${WEB_USER}

WORKDIR ${WEB_ROOT}
 
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["php-fpm"]
