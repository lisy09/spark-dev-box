ifneq (,$(wildcard ./.env))
    include .env
    export
endif

BUILD_SCRIPTS_PATH = ./build_scripts

.PHONY: all
all: base  

.PHONY: base
base:
	$(BUILD_SCRIPTS_PATH)/build_scala_base.sh

.PHONY: push
push:
	$(BUILD_SCRIPTS_PATH)/push_images.sh

.PHONY: clear
clear:
	$(BUILD_SCRIPTS_PATH)/clear.sh

.PHONY: delete-images
delete-images:
	$(BUILD_SCRIPTS_PATH)/delete_local_images.sh

.PHONY: run-base
run-base:
	$(BUILD_SCRIPTS_PATH)/run_scala_base.sh

.PHONY: sbt-run
sbt-run:
	sbt "run conf/app.conf"

.PHONY: sbt-assembly
sbt-assembly:
	sbt clean assembly

.PHONY: jar
jar:
	${BUILD_SCRIPTS_PATH}/build_jar.sh