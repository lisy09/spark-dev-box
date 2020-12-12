#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker run -it --rm \
    --name scala-dev \
    -v ${ROOT_DIR}:/root/workspace \
    -t ${DOCKER_REPO}scala-dev-base:${SCALA_DEV_DOCKER_TAG} \
    bash

set +x