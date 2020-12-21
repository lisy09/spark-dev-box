ifneq (,$(wildcard ./.env))
    include .env
    export
endif

BUILD_SCRIPTS_PATH = ./build_scripts

.PHONY: all
all: livy 

.PHONY: livy
livy:
	$(BUILD_SCRIPTS_PATH)/build_livy.sh

.PHONY: push
push:
	$(BUILD_SCRIPTS_PATH)/push_images.sh

.PHONY: clean
clean:
	$(BUILD_SCRIPTS_PATH)/delete_local_images.sh

.PHONY: deploy
deploy: deploy-hadoop deploy-livy

.PHONY: undeploy
undeploy: undeploy-livy undeploy-hadoop

.PHONY: deploy-livy
deploy-livy:
	docker-compose --env-file .env -f docker-compose.yml up -d

.PHONY: undeploy-livy
undeploy-livy:
	docker-compose --env-file .env -f docker-compose.yml down


.PHONY: deploy-hadoop
deploy-hadoop:
	cd ./vendor/hadoop-docker && make deploy

.PHONY: undeploy-hadoop
undeploy-hadoop:
	cd ./vendor/hadoop-docker && make undeploy

.PHONY: submit
submit:
	curl -X POST -H "Content-Type: application/json" -H "X-Requested-By: user" -d '{"file":"file:///root/livy-local-files/spark-examples.jar","className":"org.apache.spark.examples.JavaSparkPi"}' http://localhost:${LIVY_PORT_INTERNAL}/batches
