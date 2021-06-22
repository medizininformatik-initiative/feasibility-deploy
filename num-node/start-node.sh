#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy
export PORT_NUM_NODE_REV_PROXY=443

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/aktin-client/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/flare/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/blaze-server/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/rev-proxy/docker-compose.yml up -d
# sh $BASE_DIR/dsf-client/start.sh $COMPOSE_PROJECT
