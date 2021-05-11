###################################################################################################
# Local
###################################################################################################
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
	cp -n .env.ci .env || true

start-backend-dev:
	npx nodemon --exec node -r dotenv/config ./node_modules/@babel/node/bin/babel-node.js server/bin/server.js

start-frontend-dev:
	npx webpack serve

lint:
	npx eslint .

test:
	npm test -s

###################################################################################################
# Dev
###################################################################################################
compose:
	cp -n .env.ci .env || true
	docker-compose -f docker-compose.dev.yml down -v
	docker-compose -f docker-compose.dev.yml up -d

compose-migrate:
	docker-compose -f docker-compose.dev.yml exec -T backend make db-migrate

compose-down:
	docker-compose -f docker-compose.dev.yml down

compose-logs-backend:
	docker-compose -f docker-compose.dev.yml logs --follow backend
compose-logs-frontend:
	docker-compose -f docker-compose.dev.yml logs --follow frontend

compose-psql:
	 docker-compose -f docker-compose.dev.yml exec hexlet-postgres psql hexlet -U hexlet_user

compose-bash:
	 docker-compose -f docker-compose.dev.yml exec backend bash

###################################################################################################
# CI
###################################################################################################
compose-ci: compose-ci-up compose-ci-setup

compose-ci-up:
	docker-compose up -d

compose-ci-setup:
	docker-compose exec -T app make setup

compose-ci-lint:
	docker-compose exec -T app make lint

compose-ci-test:
	docker-compose exec -T app make test
