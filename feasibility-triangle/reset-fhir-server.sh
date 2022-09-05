#!/bin/bash

COMPOSE_PROJECT=${COMPOSE_PROJECT:-feasibility-deploy}

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
docker-compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/docker-compose.yml down -v
docker-compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/docker-compose.yml up -d
