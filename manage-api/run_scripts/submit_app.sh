#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

curl -X POST \
    -H "Content-Type: application/json" \
    -d '{
        "sparkAppName": "testApp"
    }' \
    http://localhost:${SERVER_PORT}/v1/stream

set +x