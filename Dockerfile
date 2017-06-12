FROM  bitnami/wordpress:4.7.5-r5
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

RUN set -x \
    && mkdir -p /etc/apt/sources.list.d/ \
    && echo "deb http://deb.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list \
    && gpg --keyserver pgpkeys.mit.edu --recv-key  8B48AD6246925553 \
    && gpg -a --export 8B48AD6246925553 | apt-key add - \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y -t jessie-backports certbot \
    && rm -rf /var/lib/apt/lists/*
