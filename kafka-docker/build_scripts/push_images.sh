#!/bin/bash

set -x

docker push ${DOCKER_REPO}kafka:${KAFKA_DOCKER_TAG}
docker push ${DOCKER_REPO}zookeeper:${ZOOKEEPER_DOCKER_TAG}

set +x