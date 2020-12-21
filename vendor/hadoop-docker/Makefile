ifneq (,$(wildcard ./.env))
    include .env
    export
endif

BUILD_SCRIPTS_PATH = ./build_scripts

.PHONY: all
all: base namenode datanode resourcemanager nodemanager historyserver submit

.PHONY: base
base:
	$(BUILD_SCRIPTS_PATH)/build_base.sh

.PHONY: namenode
namenode:
	$(BUILD_SCRIPTS_PATH)/build_namenode.sh

.PHONY: datanode
datanode:
	$(BUILD_SCRIPTS_PATH)/build_datanode.sh

.PHONY: resourcemanager
resourcemanager:
	$(BUILD_SCRIPTS_PATH)/build_resourcemanager.sh

.PHONY: nodemanager
nodemanager:
	$(BUILD_SCRIPTS_PATH)/build_nodemanager.sh

.PHONY: historyserver
historyserver:
	$(BUILD_SCRIPTS_PATH)/build_historyserver.sh

.PHONY: submit
submit:
	$(BUILD_SCRIPTS_PATH)/build_submit.sh

.PHONY: push
push:
	$(BUILD_SCRIPTS_PATH)/push_images.sh

.PHONY: clean
clean:
	@echo ">> delete local docker images"
	$(BUILD_SCRIPTS_PATH)/delete_local_images.sh

.PHONY: deploy
deploy:
	docker-compose --env-file .env -f docker-compose.yml up -d

.PHONY: undeploy
undeploy:
	docker-compose --env-file .env -f docker-compose.yml down

.PHONY: wordcount
wordcount:
	./test_scripts/run_wordcount.sh