current-dir := $(PWD)
OS = $(shell uname)
UID = $(shell id -u)
GID = $(shell id -g)
PHP_VERSION = 8.4
NGINX_VERSION = 1.27.4
REGISTY = kiviev
FPM_IMAGE_NAME = $(REGISTY)/php-fpm

NAMESERVER_IP = $(shell ip address | grep docker0)
ifeq ($(OS), Linux) # mac
	NAMESERVER_IP = host.docker.internal
else ifeq ($(NAMESERVER_IP),) # windows
	NAMESERVER_IP = $(shell grep nameserver /etc/resolv.conf | cut -d ' ' -f2)
else
	NAMESERVER_IP = 172.17.0.1
endif

args = $(foreach a,$($(subst -,_,$1)_args),$(if $(value $a),$a="$($a)"))

help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

ip:
	@echo $(NAMESERVER_IP)

build_php_base: ## Build php base image
	@docker build -t $(FPM_IMAGE_NAME):base -t $(FPM_IMAGE_NAME):base$(PHP_VERSION) --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg TARGET=base --build-arg UID=$(UID) --no-cache ./build/php

push_php_base: ## Push php base image
	@docker push $(FPM_IMAGE_NAME):base
	@docker push $(FPM_IMAGE_NAME):base$(PHP_VERSION)

build_and_push_base: ## Build And Push php base image
	make build_php_base
	make push_php_base

build_php_dev: ## Build php dev image
	@docker build -t $(FPM_IMAGE_NAME):dev -t $(FPM_IMAGE_NAME):dev$(PHP_VERSION) --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg TARGET=dev --build-arg UID=$(UID) --no-cache ./build/php

push_php_dev: ## Push php dev image
	@docker push $(FPM_IMAGE_NAME):dev
	@docker push $(FPM_IMAGE_NAME):dev$(PHP_VERSION)

build_and_push_dev: ## Build And Push php dev image
	make build_php_dev
	make push_php_dev


build_nginx: ## Build nginx image
	@docker build -t $(REGISTY)/nginx:$(NGINX_VERSION) --build-arg VERSION=$(NGINX_VERSION) --build-arg TARGET=web --build-arg UID=$(UID) --no-cache ./build/nginx


test:
	echo ${UID}