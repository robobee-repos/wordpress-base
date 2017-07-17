FROM  wordpress:4.8.0-fpm
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

ARG APT_CACHE
ENV WEB_ROOT /var/www/html
ENV WEB_USER www-data
ENV PHP_MAX_EXECUTION_TIME 300
ENV PHP_MEMORY_LIMIT_MB 128
ENV PHP_FPM_MAX_CHILDREN 5
ENV PHP_FPM_START_SERVERS 2
ENV PHP_FPM_MIN_SPARE_SERVERS 1
ENV PHP_FPM_MAX_SPARE_SERVERS 3
ENV PHP_OPCACHE_ENABLE_CLI 0
ENV PHP_OPCACHE_ENABLE 1
ENV PHP_OPCACHE_MEMORY_CONSUMPTION_MB 128
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES 4000

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
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-super-cache.1.4.9.zip '58e10c3cb7905fa58bc2ae1764bb1615bc1baed3cf7ba582d11bf5e8bb821766'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-piwik.1.0.15.zip '3ddc77d039619781cd51bb419d2fba68e80183672ac12af7de0a41073ddad287'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/si-contact-form.4.0.52.zip '4d4f2580c66b26c7a2bb825852bcb0624f6c2a60e443865864a0643589270054'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.3.2.zip 'ff5cd5f0bccd9999e965a888220afa036e7f6b530751769e4bcabe58224d1c67'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-smushit.2.7.1.zip 'e919a582a51541a76db7c66b3494060adaea0b1b52f6ae219836c7a53f51487e'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-optimize.2.1.1.zip 'ecb2e302e228bb9043efc01088ba297661eb6905223268afcb966161b1050761'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/the-events-calendar.4.5.8.zip 'c131574318605c16fa05408f88ca78fab08eb6d19de4b81eaf29952964a03011'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/broken-link-checker.1.11.3.zip 'c4c44e9030aa2f4a808656b75774ecf61c28f6e384eab33dc3240a41505cc716'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/add-to-any.1.7.12.zip '6be142de031971713804bc30cfd3f065fefd9ee31fc6d54f8428a18ff139b54d'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/cookie-notice.1.2.38.zip '96cda4831cd9cafe95f2a820ce46494181a28c76529e2898392958cc60ec3cd6'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/akismet.3.3.3.zip 'c03cc1ad9f92658256cc54c9680c74bf548f4be916dd93128318fa4b058f3c30'

# Install themes

ADD rootfs/install_wp_theme.sh /usr/local/bin/install_wp_theme.sh

RUN set -x \
  && chmod +x /usr/local/bin/install_wp_theme.sh

# Php configuration.

RUN set -x \
  && mkdir -p /php-in \
  && mkdir -p /php-fpm-in

ADD rootfs/www.conf /usr/local/etc/php-fpm.d/zz-www.conf

ADD rootfs/opcache-recommended.ini /usr/local/etc/php/conf.d/zz-opcache-recommended.ini

ADD rootfs/conf.ini /usr/local/etc/php/conf.d/zz-conf.ini

# Finishing up.

ADD rootfs/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-in.sh

RUN set -x \
  && chmod +x /usr/local/bin/docker-entrypoint-in.sh \
  && mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-org.sh \
  && mv /usr/local/bin/docker-entrypoint-in.sh /usr/local/bin/docker-entrypoint.sh

WORKDIR ${WEB_ROOT}
 
USER ${WEB_USER}

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm"]
