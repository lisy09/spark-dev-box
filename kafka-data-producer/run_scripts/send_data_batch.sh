#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker run -it --rm \
    --network app \
    -v ${ROOT_DIR}/data:/workspace/data \
    -v ${ROOT_DIR}/client:/workspace/client \
    -t ${DOCKER_REPO}kafka-data-producer:${DOCKER_TAG} \
    python client/send_local_data.py

set +x