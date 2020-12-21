#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

instance=$(docker run -d --rm \
    -t ${DOCKER_REPO}fastapi-server-base:${DOCKER_TAG} \
    /bin/sh -c "while :; do sleep 10; done")

docker exec $instance bash -c "cd /workspace; python -m server.export.export_api_html"
docker cp $instance:/workspace/redoc.html $ROOT_DIR/

docker stop $instance

set +x