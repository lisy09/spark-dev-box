ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.PHONY: deploy
deploy:
	docker-compose --env-file .env -f docker-compose.yml up -d

.PHONY: undeploy
undeploy:
	docker-compose --env-file .env -f docker-compose.yml down