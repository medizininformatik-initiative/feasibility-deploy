#!/usr/bin/env sh

# Arguments
#   1: docker-compose project token

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

docker-compose -p $1 -f $BASE_DIR/docker-compose.yml stop
