FROM  wordpress:4.8.0-fpm
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

ARG APT_CACHE
ENV WEB_ROOT /var/www/html

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
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/si-contact-form.4.0.51.zip '14f535d3cc2a6c7ed9a68d6a3ff88e673e1c2679bee657365c09bbcc092e3a25'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.3.2.zip 'ff5cd5f0bccd9999e965a888220afa036e7f6b530751769e4bcabe58224d1c67'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-smushit.2.7.1.zip 'e919a582a51541a76db7c66b3494060adaea0b1b52f6ae219836c7a53f51487e'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-optimize.2.1.1.zip 'ecb2e302e228bb9043efc01088ba297661eb6905223268afcb966161b1050761'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/the-events-calendar.4.5.5.zip '4da34c812d4410c2149933e4589b99369ea6820a8923d0c39a432f6b3c7abfa8'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/broken-link-checker.1.11.3.zip 'c4c44e9030aa2f4a808656b75774ecf61c28f6e384eab33dc3240a41505cc716'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/add-to-any.1.7.11.zip '5cbed017cbdf76392e4072a1a44d225d8feb67d9aa0b07c4216a6398a21388f8'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/cookie-notice.1.2.38.zip '96cda4831cd9cafe95f2a820ce46494181a28c76529e2898392958cc60ec3cd6'

# Install themes

ADD rootfs/install_wp_theme.sh /usr/local/bin/install_wp_theme.sh

RUN set -x \
  && chmod +x /usr/local/bin/install_wp_theme.sh

# Php configuration.

ENV PHP_MAX_EXECUTION_TIME 300
ENV PHP_MEMORY_LIMIT_MB 128
ENV PHP_FPM_MAX_CHILDREN 5
ENV PHP_FPM_START_SERVERS 2
ENV PHP_FPM_MIN_SPARE_SERVERS 1
ENV PHP_FPM_MAX_SPARE_SERVERS 3
ENV PHP_OPCACHE_ENABLE_CLI 1
ENV PHP_OPCACHE_ENABLE 1
ENV PHP_OPCACHE_MEMORY_CONSUMPTION_MB 128

RUN set -x \
  && mkdir -p /php-in \
  && mkdir -p /php-fpm-in

RUN { \
    echo '[www]'; \
    echo 'pm = dynamic'; \
    echo 'pm.max_children = ${PHP_FPM_MAX_CHILDREN}'; \
    echo 'pm.start_servers = ${PHP_FPM_START_SERVERS}'; \
    echo 'pm.min_spare_servers = ${PHP_FPM_MIN_SPARE_SERVERS}'; \
    echo 'pm.max_spare_servers = ${PHP_FPM_MAX_SPARE_SERVERS}'; \
    echo 'pm.status_path = /phpstatus'; \
    echo 'ping.path = /ping'; \
    echo 'ping.response = pong'; \
} > /usr/local/etc/php-fpm.d/99-www.conf

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
    echo 'opcache.memory_consumption=${PHP_OPCACHE_MEMORY_CONSUMPTION_MB}'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=${PHP_OPCACHE_ENABLE_CLI}'; \
    echo 'opcache.enable=${PHP_OPCACHE_ENABLE}'; \
    echo 'opcache.revalidate_freq=60'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
    echo 'max_execution_time=${PHP_MAX_EXECUTION_TIME}'; \
    echo 'memory_limit=${PHP_MEMORY_LIMIT_MB}M'; \
    echo 'realpath_cache_size = 1MB'; \
} > /usr/local/etc/php/conf.d/99-conf.ini

# Finishing up.

ADD rootfs/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-in.sh

RUN set -x \
  && chmod +x /usr/local/bin/docker-entrypoint-in.sh \
  && mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-org.sh \
  && mv /usr/local/bin/docker-entrypoint-in.sh /usr/local/bin/docker-entrypoint.sh

USER www-data

WORKDIR $WEB_ROOT

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm"]
