#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy
export PORT_NUM_NODE_REV_PROXY=443

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/aktin-client/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/flare/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/blaze-server/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/rev-proxy/docker-compose.yml up -d
sh $BASE_DIR/dsf-client/start.sh $COMPOSE_PROJECT
