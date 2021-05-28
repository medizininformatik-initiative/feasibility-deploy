#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/docker-compose.yml down -v
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/docker-compose.yml up -d
