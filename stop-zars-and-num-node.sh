#!/bin/sh

export COMPOSE_PROJECT=codex-deploy


printf "Stopping ZARS components ..."
cd zars
cd keycloak
docker-compose -p $COMPOSE_PROJECT stop

cd ../flare
docker-compose -p $COMPOSE_PROJECT stop

cd ../backend
docker-compose -p $COMPOSE_PROJECT stop

cd ../gui
docker-compose -p $COMPOSE_PROJECT stop

cd ../aktin-broker
docker-compose -p $COMPOSE_PROJECT stop

cd ../dsf-broker
./stop.sh -p $COMPOSE_PROJECT


printf "Stopping Num-Node components"
cd ../../num-node

cd aktin-client
docker-compose -p $COMPOSE_PROJECT stop

cd dsf-client
./stop -p $COMPOSE_PROJECT

cd ../flare
docker-compose -p $COMPOSE_PROJECT stop

cd ../fhir-server/blaze-server
docker-compose -p $COMPOSE_PROJECT stop

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT stop
