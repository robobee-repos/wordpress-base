FROM  wordpress:4.8.2-fpm
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
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/add-to-any.1.7.19.zip 'fbd140637ee20a8e7ce26760ad7bed760e935f60dd55d160449291590d2967bc'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/akismet.4.0.zip '2dbced204cca22ca782dec462ba063ab696bbf2baa61f6442bd7dd00bd93bf61'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip '6ecbeadc039363869a9cddb79b967f85465a146af5a47329201eb768ba41d8e7'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.5.1.zip '0afaf48ba59c76e2fc418ae03239feec582da68d098a43fc4406a57ce3838952'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/broken-link-checker.1.11.5.zip 'd9809a17fe79d274f903267341bb82b00a1c215a2e6c161b154eecf5c381f0b3'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/cookie-notice.1.2.39.zip 'c428ee041cd3bdc3df88f5712620dadcb1c03c0cbe7f7bcdfb39cedef5163356'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/si-contact-form.4.0.56.zip '1d2b9cda2c0d61f61fc2893a6c66216280a2d991de4d584414b2e08b67e20e39'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/favicon-by-realfavicongenerator.zip '9721141ed1df9b4286fbef4b9e8b2a30bbae8d5d1342a30701017be852eeada3'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/the-events-calendar.4.6.1.zip '42d1892c62b58a0425d4fcc58e1dd3abc0ceb0d811029b1d5f079fef077748d1'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-piwik.zip 'f78555aec5d9644b5e1919aedcc24a8e5f20f7bdb55056006e3b85847b718497'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-super-cache.1.5.7.1.zip '92b2a0a9d347b795e3ac1e0389b904665400f048f09fa5328089c50ff5b9d17c'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-optimize.2.1.1.zip 'ecb2e302e228bb9043efc01088ba297661eb6905223268afcb966161b1050761'

RUN set -x \
  && install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-mail-smtp.0.10.1.zip '2d22d3e1f37637b106df12b005308cc0faf38cb8f9190cc0622ef6537c76a1c5'

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
