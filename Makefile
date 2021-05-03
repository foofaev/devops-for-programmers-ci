# @TODO add tests with docker-compose
test:
	test -f Dockerfile
	test -f docker-compose.yml

###################################################################################################
# Local development
###################################################################################################
setup-and-start: setup start

start:
	npm run start

setup: prepare build

install:
	npm clean-install

db-migrate:
	node -r dotenv/config ./node_modules/knex/bin/cli.js migrate:latest

build:
	npm run build

prepare:
	cp -n .env.example .env || true

start-backend-dev:
	npx nodemon --exec node -r dotenv/config ./node_modules/@babel/node/bin/babel-node.js server/bin/server.js

start-frontend-dev:
	npx webpack serve

lint-code:
	npx eslint .

test-code:
	npm test -s

###################################################################################################
# Development using docker
###################################################################################################
compose-dev:
	docker-compose -f docker-compose.dev.yml down -v
	docker-compose -f docker-compose.dev.yml build
	docker-compose -f docker-compose.dev.yml run backend make db-migrate
	docker-compose -f docker-compose.dev.yml up -d

compose-dev-up:
	docker-compose -f docker-compose.dev.yml down
	docker-compose -f docker-compose.dev.yml up -d

compose-dev-down:
	docker-compose -f docker-compose.dev.yml down
	docker-compose -f docker-compose.dev.yml up -d

compose-logs-backend:
	docker-compose -f docker-compose.dev.yml logs --follow backend
compose-logs-frontend:
	docker-compose -f docker-compose.dev.yml logs --follow frontend

compose-psql:
	 docker-compose -f docker-compose.dev.yml exec hexlet-postgres psql hexlet -U hexlet_user

###################################################################################################
# Production-like setup
###################################################################################################
compose:
	docker-compose down -v
	docker-compose -f docker-compose.yml up

compose-install:
	docker-compose run app make build

compose-start:
	docker-compose up --no-build --abort-on-container-exit

compose-setup: compose-down compose-build compose-install

compose-build:
	docker-compose build

compose-down:
	docker-compose down -v || true

compose-stop:
	docker-compose stop || true

compose-restart:
	docker-compose restart

compose-bash:
	docker-compose run app bash

.PHONY: setup test
