current-dir := $(PWD)
OS = $(shell uname)
UID = $(shell id -u)
GID = $(shell id -g)

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

ip: ## NAMESERVER_IP
	@echo $(NAMESERVER_IP)

pwd: ## current dir
	@echo $(current-dir)