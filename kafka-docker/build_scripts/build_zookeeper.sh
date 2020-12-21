#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg ZOOKEEPER_VERSION=${ZOOKEEPER_VERSION} \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg ZOOKEEPER_CLIENT_PORT=${ZOOKEEPER_CLIENT_PORT} \
    --build-arg ZOOKEEPER_FOLLOWER_PORT=${ZOOKEEPER_FOLLOWER_PORT} \
    --build-arg ZOOKEEPER_ELECTION_PORT=${ZOOKEEPER_ELECTION_PORT} \
    -t ${DOCKER_REPO}zookeeper:${ZOOKEEPER_DOCKER_TAG} \
    ${ROOT_DIR}/zookeeper

set +x