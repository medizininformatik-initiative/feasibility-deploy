#!/bin/sh

export COMPOSE_PROJECT=codex-deploy


cd keycloak
docker-compose -p $COMPOSE_PROJECT stop

cd ../flare
docker-compose -p $COMPOSE_PROJECT stop

cd ../backend
docker-compose -p $COMPOSE_PROJECT stop

cd ../gui
docker-compose -p $COMPOSE_PROJECT stop