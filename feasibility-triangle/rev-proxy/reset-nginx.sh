#!/usr/bin/env sh

export COMPOSE_IGNORE_ORPHANS=True
COMPOSE_PROJECT=codex-deploy

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/docker-compose.yml down
docker compose -p "$COMPOSE_PROJECT" -f "$BASE_DIR"/docker-compose.yml up -d
