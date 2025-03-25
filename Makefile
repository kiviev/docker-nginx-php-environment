current-dir := $(PWD)
OS = $(shell uname)
UID = $(shell id -u)
GID = $(shell id -g)
SYMPHONY_VERSION = "7.2.x"

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

composer: ## composer exec example: make composer params='update'
	@docker run --rm --interactive --tty \
      --volume ./app:/app \
      composer $(filter-out $@,$(MAKECMDGOALS))

composer_update: ## composer update project
	make composer update

composer_require: ## example: make composer_require symfony/uid
	make composer require $(filter-out $@,$(MAKECMDGOALS))

install_sf: ## install symphony skeleton
	@docker run --rm --interactive --tty \
      --volume ./:/app \
      composer create-project symfony/skeleton:"$(SYMPHONY_VERSION)" app

install_sf_webapp: ## install symphony skeleton and webapp
	make install_sf
	make composer_require webapp

install_sf_api: ## install symphony skeleton and api
	make install_sf
	make composer_require api

sf:
	@docker run --rm --interactive --tty \
          --volume ./app/:/var/www/app/ \
          kiviev/php-fpm:dev8.4 bash -c "php bin/console $(filter-out $@,$(MAKECMDGOALS))"

# Esto evita que Make intente interpretar los parámetros como objetivos
%:
	@: