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

.PHONY: api-export
api-export:
	bash ${RUN_SCRIPTS_PATH}/export_api_html.sh

.PHONY: api-export-local
api-export-local:
	python -m server.export.export_api_html

.PHONY: deploy
deploy:
ifeq (,$(shell docker network ls -f name=app -q))
	@docker network create app
endif
	docker-compose --env-file .env -f docker-compose.yml up -d
	
.PHONY: undeploy
undeploy:
	docker-compose --env-file .env -f docker-compose.yml down

.PHONY: curl-wordcount
curl-wordcount:
	bash ${RUN_SCRIPTS_PATH}/curl_wordcount.sh

