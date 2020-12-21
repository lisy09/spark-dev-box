#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg JAVA_VERSION=${JAVA_VERSION} \
    --build-arg SCALA_VERSION=${SCALA_VERSION} \
    --build-arg SBT_VERSION=${SBT_VERSION} \
    -t ${DOCKER_REPO}scala-dev-base:${SCALA_DEV_DOCKER_TAG} \
    ${ROOT_DIR}/scala-dev-base

set +x