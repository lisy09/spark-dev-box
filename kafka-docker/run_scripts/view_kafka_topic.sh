#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker run --rm \
    --network app \
    -t ${DOCKER_REPO}kafka:${KAFKA_DOCKER_TAG} \
    /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka:${KAFKA_PORT} --topic test_topic #--from-beginning
set +x