#!/bin/bash

set -x

docker push ${DOCKER_REPO}scala-dev-base:${SCALA_DEV_DOCKER_TAG}

set +x