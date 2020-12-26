ifneq (,$(wildcard ./.env))
    include .env
    export
endif

BUILD_SCRIPTS_PATH = ./build_scripts
RUN_SCRIPTS_PATH = ./run_scripts

.PHONY: all
all: zookeeper kafka

.PHONY: zookeeper
zookeeper:
	$(BUILD_SCRIPTS_PATH)/build_zookeeper.sh

.PHONY: kafka
kafka:
	$(BUILD_SCRIPTS_PATH)/build_kafka.sh

.PHONY: deploy
deploy:
ifeq (,$(shell docker network ls -f name=app -q))
	@docker network create app
endif
	docker-compose --env-file .env -f docker-compose.yml up -d
.PHONY: undeploy
undeploy:
	docker-compose --env-file .env -f docker-compose.yml down

.PHONY: view-topic
view-topic:
	$(RUN_SCRIPTS_PATH)/view_kafka_topic.sh

.PHONY: push
BUILD_SCRIPTS_PATH:
	$(BUILD_SCRIPTS_PATH)/push_images.sh

