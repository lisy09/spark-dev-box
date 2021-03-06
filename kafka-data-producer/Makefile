ifneq (,$(wildcard ./.env))
    include .env
    export
endif

ROOT_DIR=${PWD}
BUILD_SCRIPTS_PATH=${PWD}/build_scripts
RUN_SCRIPTS_PATH=${PWD}/run_scripts

.PHONY: deploy-local
deploy-local: 
	bash ${RUN_SCRIPTS_PATH}/deploy_local.sh

.PHONY: clear-pycache
clear-pycache: 
	bash ${BUILD_SCRIPTS_PATH}/clear_pycache.sh

.PHONY: server
server: clear-pycache
	bash ${BUILD_SCRIPTS_PATH}/build_server.sh

.PHONY: request-test
request-test: 
	bash ${RUN_SCRIPTS_PATH}/curl_one_request.sh

.PHONY: send-batch
send-batch: 
	bash ${RUN_SCRIPTS_PATH}/send_data_batch.sh
	
.PHONY: deploy
deploy:
ifeq (,$(shell docker network ls -f name=app -q))
	@docker network create app
endif
	docker-compose --env-file .env -f docker-compose.yml up -d
.PHONY: undeploy
undeploy:
	docker-compose --env-file .env -f docker-compose.yml down

.PHONY: deploy-krb5
deploy-krb5:
ifeq (,$(shell docker network ls -f name=app -q))
	@docker network create app
endif
	docker-compose --env-file .env -f docker-compose.yml \
		-f docker-compose-krb5.yml up -d
.PHONY: undeploy-krb5
undeploy-krb5:
	docker-compose --env-file .env -f docker-compose.yml \
		-f docker-compose-krb5.yml down

.PHONY: export-api
export-api:
	bash ${RUN_SCRIPTS_PATH}/export_api_html.sh
