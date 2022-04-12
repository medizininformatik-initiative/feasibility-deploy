#!/usr/bin/env sh

COMPOSE_PROJECT=${FEASIBILITY_COMPOSE_PROJECT:-feasibility-deploy}

export CODEX_FEASIBILITY_BACKEND_FLARE_WEBSERVICE_BASE_URL=http://node-flare:8080
export CODEX_FEASIBILITY_BACKEND_DIRECT_ENABLED=true
export CODEX_FEASIBILITY_BACKEND_API_BASE_URL=$FEASIBILITY_BASE_URL/api/
export FEASIBILITY_KEYCLOAK_BASE_URL=$FEASIBILITY_BASE_URL/auth
AKTIN_ENABLED=${AKTIN_ENABLED:-false}


BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


if [ $AKTIN_ENABLED = true ]; then
    printf "Starting aktin broker for localhost ... \n"
    docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/aktin-broker/docker-compose.yml up -d
    export CODEX_FEASIBILITY_BACKEND_DIRECT_ENABLED=false
    export CODEX_FEASIBILITY_BACKEND_AKTIN_ENABLED=true
    printf "Sleeping 20 seconds to allow aktin to start up before backend ... \n"
    sleep 20
fi

docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/keycloak/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/backend/docker-compose.yml up -d
docker-compose -p $COMPOSE_PROJECT -f $BASE_DIR/gui/docker-compose.yml up -d



