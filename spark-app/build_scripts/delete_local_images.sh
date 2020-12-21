#!/bin/bash

docker rmi -f $(docker images | grep -e "^${DOCKER_REPO}scala-dev-base" | awk '{print $3}')