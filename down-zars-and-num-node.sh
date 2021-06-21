#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

printf "Down ZARS components ..."
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/keycloak/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/flare/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/backend/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/gui/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/aktin-broker/docker-compose.yml down
sh $BASE_DIR/zars/dsf-broker/down.sh $COMPOSE_PROJECT

printf "Down Num-Node components ..."
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/aktin-client/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/flare/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/fhir-server/blaze-server/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/fhir-server/hapi-fhir-server/docker-compose.yml down
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/rev-proxy/docker-compose.yml down
sh $BASE_DIR/num-node/dsf-client/down.sh $COMPOSE_PROJECT
