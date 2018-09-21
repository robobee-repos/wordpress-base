FROM  wordpress:4.9.8-php7.1-fpm
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
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/add-to-any.1.7.30.zip 'd823a90d90a7d3e44e61b7f00b07de9a0443211a16953e1e2b6a7fc9afebcc42'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/akismet.4.0.8.zip 'f97b57eb72df576eab5bdca26b11cf0f4d6d5a2bacc678e4db31b75686bf7996'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip '1aa7d687def9a961a59a989e854dca768a1eca3a7ef03c9161205e97f6650d23'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/atomic-blocks.1.3.4.zip '98bf9b1c8aff32dadb7511dd1aff65acc0df343dc9476c239e7323d8e1ff7f18'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.6.2.zip '4a771904f28bf47ab2fd2bea1672bd7e5ab1becca4fd756a41acf149f67f4244'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/broken-link-checker.1.11.5.zip 'd9809a17fe79d274f903267341bb82b00a1c215a2e6c161b154eecf5c381f0b3'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/contact-form-7.5.0.4.zip 'bb0abce8b4e13cb61ddd0b1edd3783194579c20b3a8cd55c266087b5fd2e610a'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/document-gallery.4.4.3.zip 'bf89e41f26b76ffff2c81df149293981079c33a121bb1f2227c7e123f9027605'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/favicon-by-realfavicongenerator.zip '2655f2e78efdcb2777847df0948fb708f79d7810db97a791aff054a10f74bb99'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/gdpr.2.1.0.zip '1c6e510d4a0fd95c96c481c84c3b0d958dc65a0f71b3b07ded5ab312a5c8b5d4'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.5.zip '9dc05c2cbd11b71b14c50e0c0cddd37af405735193730bdadd320e0608f82ab6'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/gutenberg.3.8.0.zip '65994e026c753ac0a6d7c8f6821f9b0401b663b54d6644b80a3cd859c8e3fdba'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/iubenda-cookie-law-solution.1.15.1.zip '819cb3c6247a7fde3a5cbab26022d27ad49eb33207d164359aad904bf62e3d79'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/miniorange-login-with-eve-online-google-facebook.zip '8998975fdc09d2a6ea46229b6d7fc3ee6e50e38ffa629bb505579eb4a81ebb44'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/pdf-image-generator.1.5.6.zip 'e7ff5db84e55a025e6fde9fb178057e9f61cb96ef91bc50734f914e36dbd2446'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/polylang.2.3.10.zip 'fad00ba41d61b85c69402e99628aae33e73ff6261f6078a193ef75dbb08736d3'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/post-smtp.1.9.4.zip '7096b8a8d869adc31ae80ab6b59322f821ed780b645fb450a9f2104ab1fd921a'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/responsive-lightbox.2.0.5.zip '978b6a29c16140bc9e8c732a54f7071286322d19294d46e6ec5eb6757e8e1417'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-smushit.2.8.1.zip '7795cd107a2a85c7416d3e30c675e827de7a0e056bc6267dfcb5aaee7b6ee6fe'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/syntaxhighlighter.zip '944ff3dbaec456270b5e6fcad8060a86d9233b5902cdea0297f17b91fd61dfeb'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/the-events-calendar.4.6.23.zip 'c5a826fdf97fe2492ba2fc1d1d0f35d07bef91dfcc41db44439d4f5f4e14a375'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-super-cache.1.6.4.zip 'f728753585bd9058862982a4abb96564e02ed6999ed605a538c7e08b26115808'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-optimize.2.2.4.zip '895d62014f7befef99c32a03e58da3395ae7c62c78945a4e372c67f230900b5b'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-typography.5.4.1.zip '3076078f882b58d11058770bc051179004c888e0165455056910e7efac35e4f6'

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
