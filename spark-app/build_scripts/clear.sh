#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

rm -rf ${ROOT_DIR}/{.bloop,.metals,target}
rm -rf ${ROOT_DIR}/project/{.bloop,project,target,metals.sbt}

set +x