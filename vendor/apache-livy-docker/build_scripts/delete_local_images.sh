#!/bin/bash

docker rmi -f $(docker images | grep -e "^${DOCKER_REPO}livy" | awk '{print $3}')