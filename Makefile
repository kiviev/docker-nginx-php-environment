-include make/common.mk

SYMPHONY_VERSION = "7.2.x"

composer: ## composer exec example make composer params='update'
	@docker run --rm --interactive --tty \
      --volume ./app:/app \
      composer $(filter-out $@,$(MAKECMDGOALS))

composer_update: ## composer update project
	make composer update

composer_require: ## example make composer_require symfony/uid
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

sf: ## symphony console command
	@docker run --rm --interactive --tty \
          --volume ./app/:/var/www/app/ \
          kiviev/php-fpm:dev8.4 bash -c "php bin/console $(filter-out $@,$(MAKECMDGOALS))"


%: ## This prevents Make from trying to interpret parameters as targets.
	@: