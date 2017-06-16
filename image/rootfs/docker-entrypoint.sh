#!/bin/bash
set -xe

function check_files_exists() {
  ls "$1" 1> /dev/null 2>&1
}

function copy_file() {
  file="$1"; shift
  dir="$1"; shift
  mod="$1"; shift
  if [ -e "$file" ]; then
    cp "$file" $dir/"$file"
    chmod $mod $dir/"$file"
  fi
}

function copy_php() {
  if [ ! -d /php-in ]; then
    return
  fi
  cd /php-in
  copy_file php.ini /usr/local/etc/php/ 0644
}

function copy_php_confd() {
  if [ ! -d /php-confd-in ]; then
    return
  fi
  cd /php-confd-in
  if ! check_files_exists "*.ini"; then
    return
  fi
  rsync -v "/php-confd-in/*.ini" /usr/local/etc/php/conf.d/
}

function copy_wordpress() {
  if [ ! -d /wordpress-in ]; then
    return
  fi
  cd /wordpress-in
  copy_file .htaccess "$WEB_ROOT/" 0644
  copy_file wp-config.php "$WEB_ROOT/" 0644
}

function sync_wordpress() {
  cd "$WEB_ROOT"
  if ! [ -e index.php -a -e wp-includes/version.php ]; then
    return
  fi
  rsync -rlD -v /usr/src/wordpress/. .
}

copy_php
copy_php_confd
sync_wordpress

cd "$WEB_ROOT"
echo "Running as `id`"
exec bash -x -- /usr/local/bin/docker-entrypoint-org.sh "$@"
