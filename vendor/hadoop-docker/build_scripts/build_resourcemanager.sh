#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg RESOURCEMANAGER_PORT_INTERNAL=${RESOURCEMANAGER_PORT_INTERNAL} \
    -t ${DOCKER_REPO}hadoop-resourcemanager:${DOCKER_TAG} \
    ${ROOT_DIR}/resourcemanager

set +x