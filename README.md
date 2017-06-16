# Wordpress-Base

## Description

This is a base image for Wordpress. 
It modifies the parent image insofar as
it can take input configuration files to override the image configuration
files, allowing for Kubernetes config maps.

## Environment Parameters

| Variable | Default | Description |
| ------------- | ------------- | ----- |
| PHP_MAX_EXECUTION_TIME  | 300 | max_execution_time |
| PHP_MEMORY_LIMIT_MB | 128 | memory_limit |
| PHP_OPCACHE_ENABLE_CLI | 0 | opcache.enable_cli |
| PHP_OPCACHE_ENABLE | 1 | opcache.enable |
| PHP_OPCACHE_MEMORY_CONSUMPTION_MB | 128 | opcache.memory_consumption |


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
