#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy

readlink "$0" >/dev/null
if [ $? -ne 0 ]; then
  BASE_DIR=$(dirname "$0")
else
  BASE_DIR=$(dirname "$(readlink "$0")")
fi

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/aktin-client/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/flare/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/blaze-server/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/hapi-fhir-server/docker-compose.yml stop
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/rev-proxy/docker-compose.yml stop
sh $BASE_DIR/dsf-client/stop.sh $COMPOSE_PROJECT
