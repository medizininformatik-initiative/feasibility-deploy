#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/keycloak/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/backend/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/gui/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/aktin-broker/docker-compose.yml up -d
sh $BASE_DIR/dsf-broker/start.sh $COMPOSE_PROJECT
