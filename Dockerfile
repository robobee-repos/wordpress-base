FROM  wordpress:4.8.0
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

RUN set -x \
  && mkdir -p /etc/apt/sources.list.d/ \
  && echo "deb http://deb.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list \
  && gpg --keyserver pgpkeys.mit.edu --recv-key  8B48AD6246925553 \
  && gpg -a --export 8B48AD6246925553 | apt-key add - \
  && DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y unzip wget \
  && apt-get install -y -t jessie-backports certbot \
  && rm -rf /var/lib/apt/lists/*

# Install plugins

WORKDIR /tmp

RUN set -x \
  && wget https://downloads.wordpress.org/plugin/all-in-one-wp-security-and-firewall.zip \
  && echo 'e4a7c8e2d344d03007ea6ec734f08f7b5479755966bca61121f72f8197ff85bd  all-in-one-wp-security-and-firewall.zip' | sha256sum -c \
  && cd /usr/src/wordpress/wp-content/plugins \
  && unzip /tmp/all-in-one-wp-security-and-firewall.zip \
  && cd /tmp \
  && rm all-in-one-wp-security-and-firewall.zip

RUN set -x \
  && wget https://downloads.wordpress.org/plugin/wp-super-cache.1.4.9.zip \
  && echo '58e10c3cb7905fa58bc2ae1764bb1615bc1baed3cf7ba582d11bf5e8bb821766  wp-super-cache.1.4.9.zip' | sha256sum -c \
  && cd /usr/src/wordpress/wp-content/plugins \
  && unzip /tmp/wp-super-cache.1.4.9.zip \
  && cd /tmp \
  && rm wp-super-cache.1.4.9.zip

# Install docker-entrypoint.sh

ADD rootfs/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-in.sh
ADD rootfs/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD rootfs/ports.conf /etc/apache2/ports.conf

ENV WORDPRESS_ROOT /var/www/html

RUN set -x \
  && chmod +x /usr/local/bin/docker-entrypoint-in.sh \
  && mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint-org.sh \
  && mv /usr/local/bin/docker-entrypoint-in.sh /usr/local/bin/docker-entrypoint.sh \
  && mkdir -p /wordpress-in \
  && mkdir -p /php-in \
  && chown www-data $WORDPRESS_ROOT \
  && chown www-data /etc/apache2/sites-available/000-default.conf \
  && chown www-data /etc/apache2/ports.conf \
  && chown www-data /var/run/apache2 \
  && chmod o+rwX /var/lock/ \
  && chmod o+rwX /var/log/

# Finishing up.

ENV APACHE_HTTP_PORT_NUMBER 8080
ENV APACHE_HTTPS_PORT_NUMBER 8443
ENV APACHE_SERVER_NAME localhost
ENV APACHE_SERVER_ADMIN_EMAIL admin@localhost

WORKDIR $WORDPRESS_ROOT

EXPOSE 8080
EXPOSE 8443

USER www-data
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
