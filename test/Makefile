include ../utils/Makefile.help
include ../utils/Makefile.functions

export NAME := wordpress

test: setup ##@targets Starts docker compose.
	docker-compose -p $(NAME) -f test.yaml up
.PHONY: up

rm:
	docker-compose -p $(NAME) -f test.yaml rm -f

clean: rm
	sudo rm -rf root

setup:
	for file in html db; do \
	    mkdir -p root/$${file}; \
	    sudo chmod o+rwX root/$${file}; \
	done
.PHONY: setup

count-php-files:
	docker exec test_$(NAME)_1 find /var/www/html -iname \*.php|wc -l
.PHONY: count-php-files
