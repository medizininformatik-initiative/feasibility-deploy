#!/usr/bin/env sh

# Arguments
#   1: docker-compose project token

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

docker-compose -p $1 -f $BASE_DIR/docker-compose.yml stop
