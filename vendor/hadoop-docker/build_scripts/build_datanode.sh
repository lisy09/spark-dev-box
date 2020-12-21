#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg HDFS_CONF_dfs_datanode_data_dir=${HDFS_CONF_dfs_datanode_data_dir} \
    --build-arg DATANODE_PORT_INTERNAL=${DATANODE_PORT_INTERNAL} \
    -t ${DOCKER_REPO}hadoop-datanode:${DOCKER_TAG} \
    ${ROOT_DIR}/datanode

set +x