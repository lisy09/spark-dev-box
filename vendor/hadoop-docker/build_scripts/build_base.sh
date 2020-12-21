#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg HADOOP_VERSION=${HADOOP_VERSION} \
    --build-arg HADOOP_URL=${HADOOP_URL} \
    --build-arg JAVA_VERSION=${JAVA_VERSION} \
    -t ${DOCKER_REPO}hadoop-base:${DOCKER_TAG} \
    ${ROOT_DIR}/base

set +x