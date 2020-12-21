#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg KAFKA_VERSION=${KAFKA_VERSION} \
    --build-arg KAFKA_SCALA_VERSION=${KAFKA_SCALA_VERSION} \
    --build-arg ZOOKEEPER_ELECTION_PORT=${ZOOKEEPER_ELECTION_PORT} \
    -t ${DOCKER_REPO}kafka:${KAFKA_DOCKER_TAG} \
    ${ROOT_DIR}/kafka

set +x