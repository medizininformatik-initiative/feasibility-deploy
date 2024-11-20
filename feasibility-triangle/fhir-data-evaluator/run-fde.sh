#!/usr/bin/env sh

COMPOSE_PROJECT=${FEASIBILITY_COMPOSE_PROJECT:-feasibility-deploy}

COMPOSE_IGNORE_ORPHANS=True docker compose -p "$COMPOSE_PROJECT" up -d
