# Inspired by https://itnext.io/docker-makefile-x-ops-sharing-infra-as-code-parts-ea6fa0d22946

THIS_FILE := $(lastword $(MAKEFILE_LIST))
CMD_ARGUMENTS ?= $(cmd)

.PHONY: help up down destroy start stop restart logs composer-dump-autoload composer-install composer-update npm-install npm-update root-shell shell gulp

help:
	@echo ''
	@echo 'Usage: make [TARGET] [EXTRA_ARGUMENTS]'
	@echo ''
	@echo 'CONTAINER MANAGEMENT TARGETS'
	@echo ''
	@echo '  up                      start the containers as background service'
	@echo '  down                    shutdown the containers'
	@echo '  destroy                 shutdown the containers and remove volumes'
	@echo '  start                   start the containers'
	@echo '  start                   stop the containers'
	@echo '  restart                 restart the containers'
	@echo ''
	@echo 'Optionally a specific container can be specified e.g.:'
	@echo '  `make up c=dev`'
	@echo ''
	@echo 'DEVELOPMENT TARGETS'
	@echo ''
	@echo '  composer-update         run "composer update" in the dev container'
	@echo '  composer-install        run "composer install" in the dev container'
	@echo '  composer-dump-autoload  run "composer dump-autoload" in the dev container'
	@echo '  npm-update              run "npm update" in the dev container'
	@echo '  npm-install             run "npm install" in the dev container'
	@echo '  gulp                    run the gulp watcher in the dev container'
	@echo '  shell                   start a shell as www-data user in the dev container'
	@echo '                          optionally the cmd argument can be used e.g.:'
	@echo '                            `make shell cmd="composer install dpool/extension"`'
	@echo '  root-shell              start a shell as root user in the dev container'
	@echo '                          optionally the cmd argument can be used'
	@echo ''

up:
	docker-compose -f docker-compose.yml up -d $(c)

down:
	docker-compose -f docker-compose.yml down $(c)

destroy:
	docker-compose -f docker-compose.yml down -v $(c)

start:
	docker-compose -f docker-compose.yml start $(c)

stop:
	docker-compose -f docker-compose.yml stop $(c)

restart:
	docker-compose -f docker-compose.yml restart $(c)

logs:
	docker-compose -f docker-compose.yml logs --tail=100 -f $(c)

composer-install:
	docker-compose -f docker-compose.yml run --rm --user www-data dev /usr/local/bin/composer install

composer-update:
	docker-compose -f docker-compose.yml run --rm --user www-data dev /usr/local/bin/composer update

composer-dump-autoload:
	docker-compose -f docker-compose.yml run --rm --user www-data dev /usr/local/bin/composer dump-autoload

npm-install:
	docker-compose -f docker-compose.yml run --rm --user www-data dev /usr/bin/npm install

npm-update:
	docker-compose -f docker-compose.yml run --rm --user www-data dev /usr/bin/npm update

gulp:
	docker-compose -f docker-compose.yml exec --user www-data dev /usr/bin/npx gulp

shell:
ifeq ($(CMD_ARGUMENTS),)
	# no command is given, default to shell
	docker-compose -f docker-compose.yml exec --user www-data dev /bin/bash
else
	# run the command
	docker-compose -f docker-compose.yml exec --user www-data dev /bin/sh -c "$(CMD_ARGUMENTS)"
endif

root-shell:
ifeq ($(CMD_ARGUMENTS),)
	# no command is given, default to shell
	docker-compose -f docker-compose.yml exec dev /bin/bash
else
	# run the command
	docker-compose -f docker-compose.yml exec dev /bin/sh -c "$(CMD_ARGUMENTS)"
endif
