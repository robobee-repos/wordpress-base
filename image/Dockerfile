FROM  wordpress:4.9.8-php5.6-fpm
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
  imagemagick ghostscript \
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
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/atomic-blocks.1.3.0.zip 'fd6c69730beb98c463859c93c24eb3a513756531166ef2036a848b12ee15a56f'
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
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/gdpr.2.1.0.zip '1c6e510d4a0fd95c96c481c84c3b0d958dc65a0f71b3b07ded5ab312a5c8b5d4'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.5.zip '9dc05c2cbd11b71b14c50e0c0cddd37af405735193730bdadd320e0608f82ab6'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/gutenberg.3.6.2.zip '8d3f9e494a5ce395e7bd0949e60845695c83d58966ef24846c8aca8f2287cf83'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/iubenda-cookie-law-solution.1.15.1.zip '819cb3c6247a7fde3a5cbab26022d27ad49eb33207d164359aad904bf62e3d79'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/miniorange-login-with-eve-online-google-facebook.zip '45814c1f1e7cb6ffcd2516482cf92b7ef3be8e5c3b1eb80e69751b74f95d2e39'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/pdf-image-generator.1.5.6.zip 'e7ff5db84e55a025e6fde9fb178057e9f61cb96ef91bc50734f914e36dbd2446'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/polylang.2.3.10.zip 'fad00ba41d61b85c69402e99628aae33e73ff6261f6078a193ef75dbb08736d3'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/post-smtp.1.9.4.zip '7096b8a8d869adc31ae80ab6b59322f821ed780b645fb450a9f2104ab1fd921a'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-smushit.2.8.0.1.zip '73f6a131c2304ebbd015a7b6267f62ef6cc4807500125a5f44c3dd454de03a61'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/the-events-calendar.4.6.21.zip '561408c2168ff49bae5fb7260f4658846574d0db41d102f2b5d9c7d98607ebaa'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-super-cache.1.6.3.zip 'd43d13c7830fc400b28ef9fb5e5c7fcd1cc1290ee4cecd443a0f6e94bd96625c'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-optimize.2.2.4.zip '895d62014f7befef99c32a03e58da3395ae7c62c78945a4e372c67f230900b5b'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-typography.5.3.5.zip 'f02b439d79cf3a9f3bc9b2b8432a239abe3782edb3b457a835d240f3c5fa9828'

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
