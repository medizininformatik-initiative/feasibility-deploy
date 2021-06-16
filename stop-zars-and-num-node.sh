#!/usr/bin/env sh

export COMPOSE_PROJECT=codex-deploy

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

printf "Stopping ZARS components ..."
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/keycloak/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/flare/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/backend/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/gui/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/zars/aktin-broker/docker-compose.yml stop
sh $BASE_DIR/zars/dsf-broker/stop.sh $COMPOSE_PROJECT


printf "Stopping Num-Node components"
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/aktin-client/docker-compose.yml stop
bash $BASE_DIR/num-node/dsf-client/stop.sh $COMPOSE_PROJECT
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/flare/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/fhir-server/blaze-server/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/fhir-server/hapi-fhir-server/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/num-node/rev-proxy/docker-compose.yml stop
