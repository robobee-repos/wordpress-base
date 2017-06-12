# Wordpress-Base

## Description

This is a base image for Wordpress. It bundles Apache, Php, OPCache and
Letsencrypt. It modifies the parent image insofar as Apache serves per default
on port 8080 and 8433 and is run as a non-priveleged user. Furthermore,
it can take input configuration files to override the image configuration
files, allowing for Kubernetes config maps.

## Environment Parameters

| Variable | Default | Description |
| ------------- | ------------- | ----- |
| APACHE_HTTP_PORT_NUMBER | 8080 | Apache HTTP port number. |
| APACHE_HTTPS_PORT_NUMBER | 8443 | Apache HTTPS port number. |
| APACHE_SERVER_NAME | localhost | Apache server name. |
| APACHE_SERVER_ADMIN_EMAIL | admin@localhost | Apache admin email. |


## Input Configration

| Source | Destination |
| ------------- | ------------- |
| /wordpress-in/.htaccess | /var/www/html/.htaccess |
| /wordpress-in/wp-config.php | /var/www/html/wp-config.php |
| /php-in/*.ini | /usr/local/etc/php/conf.d/ |

## Test

The docker-compose file `test.yaml` can be used to startup MySQL and the
Wordpress base containers. The Wordpress installation can be then accessed
from `localhost:8080`.

```
docker-compose -f test.yaml up > log.txt &
```
