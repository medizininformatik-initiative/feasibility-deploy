#!/bin/sh

export COMPOSE_PROJECT=codex-deploy


cd aktin-client
docker-compose -p $COMPOSE_PROJECT stop

cd ../flare
docker-compose -p $COMPOSE_PROJECT stop

cd ../fhir-server/blaze-server
docker-compose -p $COMPOSE_PROJECT stop

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT stop