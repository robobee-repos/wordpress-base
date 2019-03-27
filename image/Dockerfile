FROM  wordpress:5.1.1-php7.1-fpm
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
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/add-to-any.1.7.34.zip '82b0691a049a52ac41f6c8a1ea93ad288ee956cd2b3a9d1fd9581886186c64dd'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/akismet.4.1.1.zip '718a0fb6aa21b316f3e852ecd0f8fee8def49b67f4f1b1850845999c7ecac39e'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip 'a31c4234e15f736e616c4c7e2f43cda629ae89a1a4854c6a05bb64393f26da13'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/atomic-blocks.1.5.5.zip '7bc8891141c7f27c624f51f0bc95e369419143d92ac8a1cda1a55f31df921f2e'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/black-studio-tinymce-widget.2.6.8.zip '57db1fdc141a3da788a2928c5b1c865517547a2a073fdbb093e462e65bbb3ce0'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/broken-link-checker.1.11.8.zip '0d05d82d17915c3835bdccd3c0e5898afceeda6746a9319740b1f673f6dad0aa'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/contact-form-7.5.1.1.zip '701e2bb6d2e4e0b6fd9866344862226e1410f7344b86c0262c13ec80b582a263'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/document-gallery.4.4.3.zip 'bf89e41f26b76ffff2c81df149293981079c33a121bb1f2227c7e123f9027605'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/favicon-by-realfavicongenerator.zip '0695c44a2b56990220774dbebdd4efdf9ce7f27472de8d64f153f00dfbaf9af4'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/gdpr.2.1.0.zip '1c6e510d4a0fd95c96c481c84c3b0d958dc65a0f71b3b07ded5ab312a5c8b5d4'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.7.zip 'c366ed66ed81443aeecf10a49f5500b64de2a7969c43585aa2ad34c9991131ff'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/gutenberg.5.3.0.zip '75392c63d1d44e4c66ae07dcce8c2c2527a7291266d9278091f2ed394ee7b250'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/iubenda-cookie-law-solution.1.15.6.zip '4690ada93ddc09a9abac3cfbed942dcd70fd4ff152a85e16143a993d42cefc75'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/miniorange-login-with-eve-online-google-facebook.zip 'b1dae0d0551dfe227dcb4de40f754f988623fb3bc24c613718ceea51ab8a8ee6'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/pdf-image-generator.1.5.6.zip 'e7ff5db84e55a025e6fde9fb178057e9f61cb96ef91bc50734f914e36dbd2446'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/polylang.2.5.2.zip '10e7e3f4445085b2e0ea13a73fcd219c7bd1d3ac7ce67ad22d753f9afcccfe01'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/post-smtp.1.9.8.zip '62870c15f55af821957d69cc927a5d3c4543739c63125a9007c4546c11f2e45d'

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
