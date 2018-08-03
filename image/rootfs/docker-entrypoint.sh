#!/bin/bash
set -e

source /docker-entrypoint-utils.sh
set_debug
echo "Running as `id`"

if check_update_time; then
  sync_dir /usr/src/wordpress ${WEB_ROOT}
  update_update_time
fi

copy_files "/php-in" "/usr/local/etc/php/conf.d" "*.ini"
copy_files "/php-fpm-in" "/usr/local/etc/php-fpm.d" "*.conf"
copy_files "/wordpress-in" "${WEB_ROOT}" "*"

exec ${BASH_CMD} -- /usr/local/bin/docker-entrypoint-org.sh "$@"
