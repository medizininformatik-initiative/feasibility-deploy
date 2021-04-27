#!/bin/sh

export COMPOSE_PROJECT=codex-deploy


cd aktin-client
docker-compose -p $COMPOSE_PROJECT up -d

cd ../flare
docker-compose -p $COMPOSE_PROJECT up -d

cd ../fhir-server/blaze-server
docker-compose -p $COMPOSE_PROJECT up -d

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT up -d