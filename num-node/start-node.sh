#!/usr/bin/env sh

COMPOSE_PROJECT=codex-deploy
export PORT_NUM_NODE_REV_PROXY=443

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
FHIR_SERVER=${FHIR_SERVER:-blaze}

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/aktin-client/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/flare/docker-compose.yml up -d

if [ "$FHIR_SERVER" = "blaze" ]; then
    echo "Starting up FHIR-Server: Blaze"
    docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/blaze-server/docker-compose.yml up -d
elif [ "$FHIR_SERVER" = "hapi" ]; then
    echo "Starting up FHIR-Server: HAPI"
    docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/fhir-server/hapi-fhir-server/docker-compose.yml up -d
fi

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/rev-proxy/docker-compose.yml up -d

# sh $BASE_DIR/dsf-client/start.sh $COMPOSE_PROJECT
