#!/bin/sh

export COMPOSE_PROJECT=codex-deploy


printf "Down ZARS components ..."
cd zars
cd keycloak
docker-compose -p $COMPOSE_PROJECT down

cd ../flare
docker-compose -p $COMPOSE_PROJECT down

cd ../backend
docker-compose -p $COMPOSE_PROJECT down

cd ../gui
docker-compose -p $COMPOSE_PROJECT down

cd ../aktin-broker
docker-compose -p $COMPOSE_PROJECT down

cd ../aktin-broker
docker-compose -p $COMPOSE_PROJECT down


printf "Down Num-Node components ..."
cd ../../num-node

cd aktin-client
docker-compose -p $COMPOSE_PROJECT down

cd ../flare
docker-compose -p $COMPOSE_PROJECT down

cd ../fhir-server/blaze-server
docker-compose -p $COMPOSE_PROJECT down

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT down