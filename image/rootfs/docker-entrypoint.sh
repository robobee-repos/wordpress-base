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

function copy_php_conf() {
  dir="/php-in"
  if [ ! -d "${dir}" ]; then
    return
  fi
  cd "${dir}"
  if ! check_files_exists "*.ini"; then
    return
  fi
  rsync -v "${dir}/*.ini" /usr/local/etc/php/conf.d/
}

function copy_php_fpm_conf() {
  dir="/php-fpm-in"
  if [ ! -d "${dir}" ]; then
    return
  fi
  cd "${dir}"
  if ! check_files_exists "*.conf"; then
    return
  fi
  rsync -v "${dir}/*.conf" /usr/local/etc/php-fpm.d/
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

copy_php_conf
copy_php_fpm_conf
copy_wordpress
sync_wordpress

cd "$WEB_ROOT"
echo "Running as `id`"
exec bash -x -- /usr/local/bin/docker-entrypoint-org.sh "$@"
