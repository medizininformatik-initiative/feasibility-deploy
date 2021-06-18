#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/keycloak/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/flare/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/backend/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/gui/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/aktin-broker/docker-compose.yml up -d
sh $BASE_DIR/dsf-broker/start.sh $COMPOSE_PROJECT
