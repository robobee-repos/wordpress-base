include ../Makefile.help
include ../Makefile.functions

ROOT_DIR:=$(shell realpath root)
NGINX_CONF_DIR:=$(shell realpath nginx-in)

up: setup ##@targets Starts docker compose.
	export ROOT_DIR="$(ROOT_DIR)" \
	&& export NGINX_CONF_DIR="$(NGINX_CONF_DIR)" \
	&& docker-compose -f test.yaml up > log.txt
.PHONY: up

rm:
	export ROOT_DIR="$(ROOT_DIR)" \
	&& export NGINX_CONF_DIR="$(NGINX_CONF_DIR)" \
	&& docker-compose -f test.yaml rm

setup:
	mkdir -p $(ROOT_DIR)
	sudo chown 33:33 -R $(ROOT_DIR)
.PHONY: setup
