#!/bin/sh

export COMPOSE_PROJECT=codex-deploy


cd keycloak
docker-compose -p $COMPOSE_PROJECT up -d

cd ../flare
docker-compose -p $COMPOSE_PROJECT up -d

cd ../backend
docker-compose -p $COMPOSE_PROJECT up -d

cd ../gui
docker-compose -p $COMPOSE_PROJECT up -d