#!/bin/bash

docker rmi -f $(docker images | grep -e "^${DOCKER_REPO}hadoop-" | awk '{print $3}')