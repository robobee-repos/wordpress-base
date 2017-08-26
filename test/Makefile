include ../utils/Makefile.help
include ../utils/Makefile.functions

ROOT_DIR:=$(shell realpath root)
NGINX_CONF_DIR:=$(shell realpath nginx-in)
NAME := wordpress

test: setup ##@targets Starts docker compose.
	export ROOT_DIR="$(ROOT_DIR)" \
	&& export NGINX_CONF_DIR="$(NGINX_CONF_DIR)" \
	&& docker-compose -p $(NAME) -f test.yaml up
.PHONY: up

rm:
	export ROOT_DIR="$(ROOT_DIR)" \
	&& export NGINX_CONF_DIR="$(NGINX_CONF_DIR)" \
	&& docker-compose -p $(NAME) -f test.yaml rm

setup:
	mkdir -p $(ROOT_DIR)
	sudo chown 33:33 -R $(ROOT_DIR)
.PHONY: setup

count-php-files:
	docker exec test_$(NAME)_1 find /var/www/html -iname \*.php|wc -l
.PHONY: count-php-files
