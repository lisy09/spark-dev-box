#!/bin/bash

set -x

docker push ${DOCKER_REPO}livy:${DOCKER_TAG}

set +x