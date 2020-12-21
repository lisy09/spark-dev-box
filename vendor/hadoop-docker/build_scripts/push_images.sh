#!/bin/bash

set -x

docker push ${DOCKER_REPO}hadoop-base:${DOCKER_TAG}
docker push ${DOCKER_REPO}hadoop-namenode:${DOCKER_TAG}
docker push ${DOCKER_REPO}hadoop-datanode:${DOCKER_TAG}
docker push ${DOCKER_REPO}hadoop-resourcemanager:${DOCKER_TAG}
docker push ${DOCKER_REPO}hadoop-nodemanager:${DOCKER_TAG}
docker push ${DOCKER_REPO}hadoop-historyserver:${DOCKER_TAG}
docker push ${DOCKER_REPO}hadoop-submit:${DOCKER_TAG}

set +x