#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

cd ${ROOT_DIR}
find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

set +x