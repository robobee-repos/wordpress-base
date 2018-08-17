FROM  wordpress:4.9.7-php5.6-fpm
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

ARG APT_CACHE

RUN set -x \
  # Optional add proxy entries for apt.
  && if [ -n "${APT_CACHE}" ]; then \
  echo Acquire::ftp::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  echo Acquire::http::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  echo Acquire::https::Proxy \"$APT_CACHE\"; >> /etc/apt/apt.conf.d/08proxy;\
  fi

RUN set -x \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y rsync wget unzip \
  && rm -rf /var/lib/apt/lists/*

ENV WEB_ROOT="/var/www/html" \
  WEB_USER="www-data"

RUN set -x \
  && mkdir -p ${WEB_ROOT} \
  && chown ${WEB_USER}.${WEB_USER} $WEB_ROOT

ADD rootfs/ /

RUN set -x \
  && chmod +x /*.sh \
  && mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-org.sh \
  && ln -sf /dev/stdout /var/log/php-fpm-slow.log

# Install plugins

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/add-to-any.1.7.28.zip '64193d4a12597349e07c7ffa52e4a5f0b24822667118d1215950598651ef287b'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/akismet.4.0.8.zip 'f97b57eb72df576eab5bdca26b11cf0f4d6d5a2bacc678e4db31b75686bf7996'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip '1aa7d687def9a961a59a989e854dca768a1eca3a7ef03c9161205e97f6650d23'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.6.2.zip '4a771904f28bf47ab2fd2bea1672bd7e5ab1becca4fd756a41acf149f67f4244'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/broken-link-checker.1.11.5.zip 'd9809a17fe79d274f903267341bb82b00a1c215a2e6c161b154eecf5c381f0b3'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/contact-form-7.5.0.3.zip 'ffbaffaca3c6fa2db122135ea8de94193c4b20b7bc91e498162823bc0ba9c045'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/cookie-notice.1.2.44.zip 'e78b3dea7264e8bbc96c11d6a619941233c9c2b865827954aa7e6f8ecb4e2804'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/favicon-by-realfavicongenerator.zip '2655f2e78efdcb2777847df0948fb708f79d7810db97a791aff054a10f74bb99'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.5.zip '9dc05c2cbd11b71b14c50e0c0cddd37af405735193730bdadd320e0608f82ab6'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/post-smtp.zip 'dcfe121ea62c9124248e35cdd0cff9e7be806d0758a915879b6440f0a57df229'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/the-events-calendar.4.6.21.zip '561408c2168ff49bae5fb7260f4658846574d0db41d102f2b5d9c7d98607ebaa'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-smushit.2.8.0.zip '7c937848f2f57f1264e0d880eb4821374ce3aad06889d019722b5c9a4f22123b'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-super-cache.1.6.2.zip 'bb83b6e86baa3de3c9b085296e3947da5f9338ba41b602d9a33f9f26ae3eeb66'

RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-optimize.2.2.4.zip '895d62014f7befef99c32a03e58da3395ae7c62c78945a4e372c67f230900b5b'

# Install themes

# Php configuration.

ENV DEBUG="false" \
  SYNC_ENABLED="true" \
  SYNC_TIME_S="300" \
  PHP_MAX_EXECUTION_TIME="300" \
  PHP_MEMORY_LIMIT="128M" \
  PHP_FPM_MAX_CHILDREN="10" \
  PHP_FPM_START_SERVERS="2" \
  PHP_FPM_MIN_SPARE_SERVERS="2" \
  PHP_FPM_MAX_SPARE_SERVERS="5" \
  PHP_FPM_MAX_REQUESTS="500" \
  PHP_FPM_REQUEST_SLOWLOG_TIMEOUT="0" \
  PHP_FPM_CATCH_WORKERS_OUTPUT="1" \
  PHP_OPCACHE_ENABLE_CLI="1" \
  PHP_OPCACHE_ENABLE="1" \
  PHP_OPCACHE_MEMORY_CONSUMPTION="128" \
  PHP_OPCACHE_MAX_ACCELERATED_FILES="6000"

RUN set -x \
  && chown ${WEB_USER}.${WEB_USER} /usr/local/etc/php/conf.d \
  && chown ${WEB_USER}.${WEB_USER} /usr/local/etc/php-fpm.d

USER ${WEB_USER}

WORKDIR ${WEB_ROOT}

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm"]
