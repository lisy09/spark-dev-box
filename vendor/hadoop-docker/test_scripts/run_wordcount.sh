#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
CONF_DIR="$( cd $ROOT_DIR/conf >/dev/null 2>&1 && pwd )"

DOCKER_NETWORK=hadoop-docker_default
MOUNT_PARAMS="-v ${CONF_DIR}/core-site.xml:/etc/hadoop/core-site.xml \
      -v ${CONF_DIR}/hdfs-site.xml:/etc/hadoop/hdfs-site.xml \
      -v ${CONF_DIR}/yarn-site.xml:/etc/hadoop/yarn-site.xml \
      -v ${CONF_DIR}/mapred-site.xml:/etc/hadoop/mapred-site.xml"

set -x

docker run --network ${DOCKER_NETWORK} ${MOUNT_PARAMS} --rm ${DOCKER_REPO}hadoop-base:${DOCKER_TAG} hdfs dfs -mkdir -p /input/
docker run --network ${DOCKER_NETWORK} ${MOUNT_PARAMS} --rm ${DOCKER_REPO}hadoop-base:${DOCKER_TAG} hdfs dfs -copyFromLocal -f /opt/hadoop-${HADOOP_VERSION}/README.txt /input/
docker run --network ${DOCKER_NETWORK} ${MOUNT_PARAMS} --rm ${DOCKER_REPO}hadoop-submit:${DOCKER_TAG}
docker run --network ${DOCKER_NETWORK} ${MOUNT_PARAMS} --rm ${DOCKER_REPO}hadoop-base:${DOCKER_TAG} hdfs dfs -cat /output/*
docker run --network ${DOCKER_NETWORK} ${MOUNT_PARAMS} --rm ${DOCKER_REPO}hadoop-base:${DOCKER_TAG} hdfs dfs -rm -r /output
docker run --network ${DOCKER_NETWORK} ${MOUNT_PARAMS} --rm ${DOCKER_REPO}hadoop-base:${DOCKER_TAG} hdfs dfs -rm -r /input

set +x