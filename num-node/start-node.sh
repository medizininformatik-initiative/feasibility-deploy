#!/bin/sh

export COMPOSE_PROJECT=codex-deploy
export PORT_NUM_NODE_REV_PROXY=443

cd aktin-client
docker-compose -p $COMPOSE_PROJECT up -d

cd ../flare
docker-compose -p $COMPOSE_PROJECT up -d

cd ../fhir-server/blaze-server
docker-compose -p $COMPOSE_PROJECT up -d

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT up -d