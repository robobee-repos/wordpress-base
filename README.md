# Wordpress-Base

## Description

This is a base image for Wordpress.
It modifies the parent image insofar as
it can take input configuration files to override the image configuration
files, allowing for Kubernetes config maps.

## Updating

The files in `WEB_ROOT` are updated with `rsync` from the docker image.
To avoid endless a loop of a restarting container a timeout for updating
can be set in the variables `UPDATE_TIME_S`. No `rsync` will be called if
the restart time was less than this timeout. While `rsync` should not write
files that do not need to be updated, `rsync` is still making read requests.

## Exposed Ports

| Port | Name |
| ------------- | ----- |
| `9000`  | php-fpm |

## Environment Parameters

### General

| Variable | Default | Description |
| ------------- | ------------- | ----- |
| WEB_ROOT  | `/var/www/html` | The persistent directory of the application. |
| WEB_USER  | `www-data` | The application user. |
| SYNC_ENABLED  | `true` | Set to `false` to deactivate the application will be done. |
| SYNC_TIME_S  | `300` | Set to the seconds that will be waited before a full update of the application will be done. |
| DEBUG  | `false` | Set to `true` to enable script debug. |

### PHP

| Variable | Default | Description |
| ------------- | ------------- | ----- |
| PHP_MAX_EXECUTION_TIME  | 300 | max_execution_time |
| PHP_MEMORY_LIMIT | 128M | memory_limit |
| PHP_FPM_MAX_CHILDREN | 10 | pm.max_children |
| PHP_FPM_START_SERVERS | 2 | pm.start_servers |
| PHP_FPM_MIN_SPARE_SERVERS | 2 | pm.min_spare_servers |
| PHP_FPM_MAX_SPARE_SERVERS | 5 | pm.max_spare_servers |
| PHP_FPM_MAX_REQUESTS | 500 | pm.max_requests |
| PHP_FPM_REQUEST_SLOWLOG_TIMEOUT | 0 | request_slowlog_timeout |
| PHP_FPM_CATCH_WORKERS_OUTPUT | 1 | catch_workers_output |
| PHP_OPCACHE_ENABLE_CLI | 1 | opcache.enable_cli |
| PHP_OPCACHE_ENABLE | 1 | opcache.enable |
| PHP_OPCACHE_MEMORY_CONSUMPTION | 128 | opcache.memory_consumption |


## Input Configration

| Source | Destination |
| ------------- | ------------- |
| /php-in/php.ini | /usr/local/etc/php/php.ini |
| /php-confd-in/*.ini | /usr/local/etc/php/conf.d/ |
| /wordpress-in/.htaccess | /var/www/html/.htaccess |
| /wordpress-in/wp-config.php | /var/www/html/wp-config.php |

## Test

The docker-compose file `test.yaml` can be used to startup MySQL and the
Wordpress base containers. The Wordpress installation can be then accessed
from `localhost:8080`.

```
docker-compose -f test.yaml up
```

## Optimize php-fpm

```
docker exec wordpress_wordpress_1 find /var/www/html -iname '*.php'|wc -l
```

```
find /var/www/html -iname *.php|wc -l
```
