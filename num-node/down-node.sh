#!/bin/sh

export COMPOSE_PROJECT=codex-deploy


cd aktin-client
docker-compose -p $COMPOSE_PROJECT down -v

cd ../flare
docker-compose -p $COMPOSE_PROJECT down -v

cd ../fhir-server/blaze-server
docker-compose -p $COMPOSE_PROJECT down -v

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT down -v