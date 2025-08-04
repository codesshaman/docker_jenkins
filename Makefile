name = Jenkins

NO_COLOR=\033[0m	# Color Reset
COLOR_OFF='\e[0m'       # Color Off
OK_COLOR=\033[32;01m	# Green Ok
ERROR_COLOR=\033[31;01m	# Error red
WARN_COLOR=\033[33;01m	# Warning yellow
RED='\e[1;31m'          # Red
GREEN='\e[1;32m'        # Green
YELLOW='\e[1;33m'       # Yellow
BLUE='\e[1;34m'         # Blue
PURPLE='\e[1;35m'       # Purple
CYAN='\e[1;36m'         # Cyan
WHITE='\e[1;37m'        # White
UCYAN='\e[4;36m'        # Cyan
USER_ID = $(shell id -u)

all:
	@printf "Launch configuration ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build grafana

help:
	@echo -e "$(OK_COLOR)==== All commands of ${name} configuration ====$(NO_COLOR)"
	@echo -e "$(WARN_COLOR)- make				: Launch configuration"
	@echo -e "$(WARN_COLOR)- make build			: Building configuration"
	@echo -e "$(WARN_COLOR)- make config			: View docker-compose config and variables"
	@echo -e "$(WARN_COLOR)- make changes			: Copy changes to app and api folders"
	@echo -e "$(WARN_COLOR)- make condash			: Connect to dash container"
	@echo -e "$(WARN_COLOR)- make congra			: Connect to grafana container"
	@echo -e "$(WARN_COLOR)- make conki			: Connect to loki container"
	@echo -e "$(WARN_COLOR)- make conginx			: Connect to nginx container"
	@echo -e "$(WARN_COLOR)- make conpro			: Connect to prometheus container"
	@echo -e "$(WARN_COLOR)- make conpt			: Connect to promtail container"
	@echo -e "$(WARN_COLOR)- make conpg			: Connect to pushgateway container"
	@echo -e "$(WARN_COLOR)- make conpos			: Connect to postgres container"
	@echo -e "$(WARN_COLOR)- make down			: Stopping configuration"
	@echo -e "$(WARN_COLOR)- make env			: Create .env-file"
	@echo -e "$(WARN_COLOR)- make localbuild		: Build dash container"
	@echo -e "$(WARN_COLOR)- make logs			: Show dash logs"
	@echo -e "$(WARN_COLOR)- make link			: Create app folder symlink"
	@echo -e "$(WARN_COLOR)- make git			: Set user name and email to git"
	@echo -e "$(WARN_COLOR)- make push			: Push changes to the github"
	@echo -e "$(WARN_COLOR)- make ps			: View configuration"
	@echo -e "$(WARN_COLOR)- make rights			: Correctly rights for files"
	@echo -e "$(WARN_COLOR)- make re			: Rebuild dash configuration"
	@echo -e "$(WARN_COLOR)- make reall			: Rebuild all configuration"
	@echo -e "$(WARN_COLOR)- make redash			: Rebuild dash configuration"
	@echo -e "$(WARN_COLOR)- make reginx			: Rebuild nginx configuration"
	@echo -e "$(WARN_COLOR)- make repos			: Rebuild postgres configuration"
	@echo -e "$(WARN_COLOR)- make clean			: Cleaning configuration$(NO_COLOR)"

build:
	@printf "$(YELLOW)==== Building configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --build
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build grafana

config:
	@printf "$(ERROR_COLOR)==== View ${name} config ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml config

changes:
	@printf "$(ERROR_COLOR)==== Copy changes from repo... ====$(NO_COLOR)\n"
	@bash ./scripts/copy_change.sh

condash:
	@printf "$(ERROR_COLOR)==== Connect to dash container... ====$(NO_COLOR)\n"
	@docker exec -it dash bash

congra:
	@printf "$(ERROR_COLOR)==== Connect to grafana container... ====$(NO_COLOR)\n"
	@docker exec -it grafana sh

conki:
	@printf "$(ERROR_COLOR)==== Connect to loki container... ====$(NO_COLOR)\n"
	@docker exec -it loki sh

conginx:
	@printf "$(ERROR_COLOR)==== Connect to nginx container... ====$(NO_COLOR)\n"
	@docker exec -it nginx sh

conpos:
	@printf "$(ERROR_COLOR)==== Connect to postgres container... ====$(NO_COLOR)\n"
	@docker exec -it postgres sh

down:
	@printf "$(ERROR_COLOR)==== Stopping configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down

env:
	@printf "$(ERROR_COLOR)==== Create environment file for ${name}... ====$(NO_COLOR)\n"
	@if [ -f .env ]; then \
		rm .env; \
	fi; \
	cp .env.example .env;

git:
	@printf "$(YELLOW)==== Set user name and email to git for ${name} repo... ====$(NO_COLOR)\n"
	@bash ./scripts/gituser.sh

localbuild:
	@printf "$(YELLOW)==== ${name} logs... ====$(NO_COLOR)\n"
	@bash ./scripts/build.sh

logs:
	@printf "$(YELLOW)==== ${name} logs... ====$(NO_COLOR)\n"
	@docker logs dash

link:
	@printf "$(YELLOW)==== App symlink... ====$(NO_COLOR)\n"
	@bash ./scripts/symlink.sh

push:
	@bash ./scripts/push.sh

rights:
	@bash ./scripts/rights.sh

re:
	@printf "$(OK_COLOR)==== Rebuild dash... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down dash
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build dash

reall: down
	@printf "$(OK_COLOR)==== Rebuild configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build

redash:
	@printf "$(OK_COLOR)==== Rebuild dash... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down dash
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build dash

redashf:
	@printf "$(OK_COLOR)==== Rebuild dash... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down dash
	@docker-compose -f ./docker-compose.yml up -d --build --force-recreate dash

reapi:
	@printf "$(OK_COLOR)==== Rebuild sm_cognos_api... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down sm_cognos_api
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build sm_cognos_api

reginx:
	@printf "$(OK_COLOR)==== Rebuild nginx... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down nginx
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build nginx

repos:
	@printf "$(OK_COLOR)==== Rebuild postgres... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down postgres
	@docker-compose -f ./docker-compose.yml up -d --no-deps --build postgres

ps:
	@printf "$(BLUE)==== View configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml ps

start:
	@printf "$(BLUE)==== Start configuration ${name}... ====$(NO_COLOR)\n"
	@bash ./scripts/start.sh

clean: 
	@printf "$(ERROR_COLOR)==== Cleaning configuration ${name}... ====$(NO_COLOR)\n"
	@yes | docker system prune -a
# 	@scripts/clean.sh

fclean: down
	@printf "$(ERROR_COLOR)==== Total clean of all configurations docker ====$(NO_COLOR)\n"
	@yes | docker system prune -a
	# Uncommit if necessary:
	# @docker stop $$(docker ps -qa)
	# @docker system prune --all --force --volumes
	# @docker network prune --force
	# @docker volume prune --force

.PHONY	: all help build down logs re refl repa reps ps clean fclean
