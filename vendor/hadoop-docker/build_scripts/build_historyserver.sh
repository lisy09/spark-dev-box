#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=${YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path} \
    --build-arg HISTORYSERVER_PORT_INTERNAL=${HISTORYSERVER_PORT_INTERNAL} \
    -t ${DOCKER_REPO}hadoop-historyserver:${DOCKER_TAG} \
    ${ROOT_DIR}/historyserver

set +x