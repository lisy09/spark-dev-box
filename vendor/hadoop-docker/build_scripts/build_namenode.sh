#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg BASE_IMAGE=${BASE_IMAGE} \
    --build-arg HDFS_CONF_dfs_namenode_name_dir=${HDFS_CONF_dfs_namenode_name_dir} \
    --build-arg NAMENODE_PORT_INTERNAL=${NAMENODE_PORT_INTERNAL} \
    -t ${DOCKER_REPO}hadoop-namenode:${DOCKER_TAG} \
    ${ROOT_DIR}/namenode

set +x