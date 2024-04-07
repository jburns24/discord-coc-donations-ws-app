-include .env
export

run:
	npm start

create-env:
	@if [ ! -f .env ]; then cp .env.sample .env; fi

echo:
	@echo $(TEST)
