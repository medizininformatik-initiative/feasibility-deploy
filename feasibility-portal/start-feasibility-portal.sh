#!/usr/bin/env sh

COMPOSE_PROJECT=${FEASIBILITY_COMPOSE_PROJECT:-feasibility-deploy}

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/keycloak/docker-compose.yml up -d
docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/backend/docker-compose.yml up -d
docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/gui/docker-compose.yml up -d
docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/proxy/docker-compose.yml up -d

