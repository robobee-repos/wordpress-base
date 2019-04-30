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
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/add-to-any.1.7.35.zip '7a539476d9dfa85564312a5a87ed9b464a70986efb50a789e0c0ca48cba98331'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/akismet.4.1.1.zip 'feb63500c70c9cd445649635e9e62507fc752196abff3dafdbc9166782366dc2'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip 'a31c4234e15f736e616c4c7e2f43cda629ae89a1a4854c6a05bb64393f26da13'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/atomic-blocks.1.7.0.zip '1292d15ca799095862edf6e2e5c906b18ae52767fcf4ea9d92405bed28a80efe'
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
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/google-analytics-dashboard-for-wp.5.3.8.zip '76603dd46651c20e8872ecc48ddf1bfe1fa6936f96e85abecf0b5bb19a96d6fd'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/gutenberg.5.5.0.zip '6d32dd45ec84568e225d3bc75814fcfb90c2d8e2bffb8816e920742276c424ad'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/iubenda-cookie-law-solution.1.15.7.zip '63bc06a6d72cfc7681533aa20f2ff76931411f6a6d533b567b7033e809159626'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/miniorange-login-with-eve-online-google-facebook.zip 'b1dae0d0551dfe227dcb4de40f754f988623fb3bc24c613718ceea51ab8a8ee6'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/pdf-image-generator.1.5.6.zip 'e7ff5db84e55a025e6fde9fb178057e9f61cb96ef91bc50734f914e36dbd2446'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/polylang.2.5.3.zip '8acc7e82e1ec359daff4eda50db7df4795b459b36fb0c59d99c88549c7e3798c'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/post-smtp.1.9.8.zip '62870c15f55af821957d69cc927a5d3c4543739c63125a9007c4546c11f2e45d'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/responsive-lightbox.zip '5ad44c68a90f4ae90881e4d07fdf2133cf21ea6960f8f6a342ce55e141ccc23b'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-smushit.3.2.0.1.zip 'bbc6310261b03d4b04909f32a412dc0e7e6e2ab2d95ea3475b1b8a287a7bbe06'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/syntaxhighlighter.zip 'ade0b0d034ec74bf58a38a9ae4c72b1b3e4e8b76b50e298a89dd9e3d242cc47e'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/the-events-calendar.4.9.0.3.zip '03aa49160419832bf7946c8a957c51666fdf34d9b592c1041b3f0aac95da01c9'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-super-cache.1.6.4.zip '168b5f8fd91ae26216e4ee8e484c84e6b222c6dddd24e1643d79c7875fbaca0c'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-optimize.2.3.3.zip 'b86b23f5e2fadba6b4e3d28c0ab399683db0e1d5ec6117b4d13506dffef3b2d2'
RUN set -x \
  && /install_wp_plugin.sh https://downloads.wordpress.org/plugin/wp-typography.5.5.4.zip '75ed5a432a5db969d639c2352a44a5e68c91dacb4a4dd52b0add784b078804d5'

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
