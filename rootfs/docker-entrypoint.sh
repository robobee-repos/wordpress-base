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

function sync_wordpress() {
  cd $WORDPRESS_ROOT
  if ! [ -e index.php -a -e wp-includes/version.php ]; then
    return
  fi
  rsync -rlD -v /usr/src/wordpress/. .
}

if [ -d /wordpress-in ]; then
  copy_wordpress
fi
if [ -d /php-in ]; then
  copy_php
fi

sync_wordpress

cd $WORDPRESS_ROOT
exec bash -x -- /usr/local/bin/docker-entrypoint-org.sh "$@"
