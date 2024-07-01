#!/bin/bash

COMPOSE_PROJECT=${COMPOSE_PROJECT:-feasibility-deploy}

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
COMPOSE_IGNORE_ORPHANS=True docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/fhir-server/docker-compose.yml down -v
COMPOSE_IGNORE_ORPHANS=True docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/fhir-server/docker-compose.yml up -d
