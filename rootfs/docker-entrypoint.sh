#!/bin/bash
set -xe

function copy_wordpress() {
  cd /wordpress-in
  file=".htaccess"
  if [ -e "$file" ]; then
    cp "$file" $WORDPRESS_ROOT/"$file"
    chmod 0644 $WORDPRESS_ROOT/"$file"
  fi
  file="wp-config.php"
  if [ -e "$file" ]; then
    cp "$file" $WORDPRESS_ROOT/"$file"
    chmod 0644 $WORDPRESS_ROOT/"$file"
  fi
}

function copy_php() {
  cd /php-in
  set +e
  cp *.ini /usr/local/etc/php/conf.d/
  set -e
}

function do_sed() {
  ## TEMP File
  TFILE=`mktemp --tmpdir tfile.XXXXX`
  trap "rm -f $TFILE" 0 1 2 3 15

  file="$1"; shift
  search="$1"; shift
  replace="$1"; shift
  sed -r -e "s/^(${search}).*/${replace}/g" $file > $TFILE
  cat $TFILE > $file
}

function update_apache_conf() {
  ##
  file="/etc/apache2/sites-available/000-default.conf"
  search="\s*<VirtualHost\s\*:"
  replace="\1${APACHE_HTTP_PORT_NUMBER}>"
  do_sed "$file" "$search" "$replace"
  search="\s*ServerName\s+"
  replace="\1${APACHE_SERVER_NAME}"
  do_sed "$file" "$search" "$replace"
  search="\s*ServerAdmin\s+"
  replace="\1${APACHE_SERVER_ADMIN_EMAIL}"
  do_sed "$file" "$search" "$replace"
  ##
  file="/etc/apache2/ports.conf"
  search="Listen "
  replace="Listen ${APACHE_HTTP_PORT_NUMBER}"
  do_sed "$file" "$search" "$replace"
  search="\s+Listen "
  replace="\1${APACHE_HTTPS_PORT_NUMBER}"
  do_sed "$file" "$search" "$replace"
}

if [ -d /wordpress-in ]; then
  copy_wordpress
fi
if [ -d /php-in ]; then
  copy_php
fi

update_apache_conf

cd $WORDPRESS_ROOT
exec bash -x -- /usr/local/bin/docker-entrypoint-org.sh "$@"
