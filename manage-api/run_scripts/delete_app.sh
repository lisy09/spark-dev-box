#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

output=$(curl http://localhost:${SERVER_PORT}/v1/stream)

targetSession=$(echo $output | jq '.sessions[] | select(.name=="testApp") | .id')
curl -X DELETE http://localhost:${SERVER_PORT}/v1/stream/$targetSession

set +x