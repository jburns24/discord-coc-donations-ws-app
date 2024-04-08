-include .env
export

up:
	docker compose up

down:
	docker compose down

create-env:
	@if [ ! -f .env ]; then cp .env.sample .env; fi

lint:
	docker compose run --rm dev sh -c "npm install --include=dev && npm run lint"

build:
	docker compose build
