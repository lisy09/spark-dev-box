
ROOT_DIR=${PWD}
SCRIPT_DIR=${ROOT_DIR}/run_scripts

.PHONY: deploy
deploy:
ifeq (,$(shell docker network ls -f name=app -q))
	@docker network create app
endif
	cd ${ROOT_DIR}/vendor/hadoop-docker && make deploy
	cd ${ROOT_DIR}/vendor/apache-livy-docker && make deploy-livy
	cd ${ROOT_DIR}/kafka-docker && make deploy
	cd ${ROOT_DIR}/redis && make deploy
	cd ${ROOT_DIR}/kafka-data-producer && make deploy
	cd ${ROOT_DIR}/word-count-api && make deploy
.PHONY: undeploy
undeploy:
	cd ${ROOT_DIR}/vendor/apache-livy-docker && make undeploy-livy
	cd ${ROOT_DIR}/vendor/hadoop-docker && make undeploy
	cd ${ROOT_DIR}/kafka-docker && make undeploy
	cd ${ROOT_DIR}/redis && make undeploy
	cd ${ROOT_DIR}/kafka-data-producer && make undeploy
	cd ${ROOT_DIR}/word-count-api && make undeploy
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

.PHONY: push-images
push-images:
	cd ${ROOT_DIR}/vendor/apache-livy-docker && make push
	cd ${ROOT_DIR}/vendor/hadoop-docker && make push
	cd ${ROOT_DIR}/kafka-docker && make push

.PHONY: jar
jar:
	cd ${ROOT_DIR}/spark-app && make jar

.PHONY: submit
submit:
	bash ${SCRIPT_DIR}/submit_to_livy.sh

.PHONY: send-batch
send-batch:
	cd ${ROOT_DIR}/kafka-data-producer && make send-batch

.PHONY: view-topic
view-topic:
	cd ${ROOT_DIR}/kafka-docker && make view-topic
