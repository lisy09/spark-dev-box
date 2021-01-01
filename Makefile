
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

ROOT_DIR=${PWD}
SCRIPT_DIR=${ROOT_DIR}/run_scripts

.PHONY: deploy
deploy:
ifeq (,$(shell docker network ls -f name=app -q))
	@docker network create app
endif
ifeq (true,$(shell echo $(USE_KERBEROS) | tr A-Z a-z))
	cd ${ROOT_DIR}/kerberos-cluster && make deploy
else
	cd ${ROOT_DIR}/kafka-docker && make deploy
endif
	cd ${ROOT_DIR}/vendor/hadoop-docker && make deploy
	cd ${ROOT_DIR}/vendor/apache-livy-docker && make deploy-livy
	cd ${ROOT_DIR}/redis && make deploy
	cd ${ROOT_DIR}/kafka-data-producer && make deploy
	cd ${ROOT_DIR}/word-count-api && make deploy
	cd ${ROOT_DIR}/manage-api && make deploy

.PHONY: undeploy
undeploy:
ifeq (true,$(shell echo $(USE_KERBEROS) | tr A-Z a-z))
	cd ${ROOT_DIR}/kerberos-cluster && make undeploy
else
	cd ${ROOT_DIR}/kafka-docker && make undeploy
endif
	cd ${ROOT_DIR}/vendor/apache-livy-docker && make undeploy-livy
	cd ${ROOT_DIR}/vendor/hadoop-docker && make undeploy
	cd ${ROOT_DIR}/redis && make undeploy
	cd ${ROOT_DIR}/kafka-data-producer && make undeploy
	cd ${ROOT_DIR}/word-count-api && make undeploy
	cd ${ROOT_DIR}/manage-api && make undeploy
	docker network rm app

.PHONY: redeploy-livy
redeploy-livy:
	cd ${ROOT_DIR}/vendor/apache-livy-docker && make undeploy-livy && make deploy-livy

.PHONY: all
all:
	cd ${ROOT_DIR}/vendor/apache-livy-docker && make all
	cd ${ROOT_DIR}/vendor/hadoop-docker && make all
	cd ${ROOT_DIR}/kafka-docker && make all
	cd ${ROOT_DIR}/spark-app && make base && make jar
	cd ${ROOT_DIR}/kafka-data-producer && make server
	cd ${ROOT_DIR}/word-count-api && make server
	cd ${ROOT_DIR}/manage-api && make server

.PHONY: push-images
push-images:
	cd ${ROOT_DIR}/vendor/apache-livy-docker && make push
	cd ${ROOT_DIR}/vendor/hadoop-docker && make push
	cd ${ROOT_DIR}/kafka-docker && make push

.PHONY: jar
jar:
	cd ${ROOT_DIR}/spark-app && make jar

.PHONY: export-api
export-api:
	cd ${ROOT_DIR}/spark-app && make jar

.PHONY: submit
submit:
	cd ${ROOT_DIR}/manage-api && make submit
.PHONY: unsubmit
unsubmit:
	cd ${ROOT_DIR}/manage-api && make unsubmit

.PHONY: send-batch
send-batch:
	cd ${ROOT_DIR}/kafka-data-producer && make send-batch

.PHONY: curl-wordcount
curl-wordcount:
	cd ${ROOT_DIR}/word-count-api && make curl-wordcount

.PHONY: view-topic
view-topic:
	cd ${ROOT_DIR}/kafka-docker && make view-topic
