#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

curl http://localhost:8000/senddata -X POST -H "Content-Type: application/json" -d '{"s":"s"}' -i

set +x