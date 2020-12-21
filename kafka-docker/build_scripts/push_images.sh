#!/bin/bash

set -x

docker push ${DOCKER_REPO}hadoop-base:${DOCKER_TAG}

set +x