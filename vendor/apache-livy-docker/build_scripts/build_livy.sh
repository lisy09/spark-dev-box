#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg PREBUILT_HADOOP=${PREBUILT_HADOOP} \
    --build-arg SPARK_SRC_URL=${SPARK_SRC_URL} \
    --build-arg SPARK_ASC_URL=${SPARK_ASC_URL} \
    --build-arg PREBUILT_LIVY=${PREBUILT_LIVY} \
    --build-arg LIVY_SRC_URL=${LIVY_SRC_URL} \
    --build-arg LIVY_ASC_URL=${LIVY_ASC_URL} \
    -t ${DOCKER_REPO}livy:${DOCKER_TAG} \
    ${ROOT_DIR}/livy_docker

set +x