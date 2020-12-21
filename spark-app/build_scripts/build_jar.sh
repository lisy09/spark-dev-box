#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
BUILD_DIR=${ROOT_DIR}/build_results

set -x

instance=$(docker run -d --rm \
    -v ${ROOT_DIR}:/root/workspace \
    -t ${DOCKER_REPO}scala-dev-base:${SCALA_DEV_DOCKER_TAG} \
    /bin/sh -c "while :; do sleep 10; done")

docker exec $instance bash -c "cd /root/workspace; sbt clean assembly; \
    mv /root/workspace/target/scala-2.12/*.jar /root/workspace/spark-app.jar"

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
mv ${ROOT_DIR}/spark-app.jar $BUILD_DIR/spark-app.jar


docker stop $instance

set +x