#!/bin/sh

export COMPOSE_PROJECT=codex-deploy


printf "Startup ZARS components ..."
cd zars

cd keycloak
docker-compose -p $COMPOSE_PROJECT up -d

#cd ../aktin-broker
#docker-compose -p $COMPOSE_PROJECT up -d

export BROKER_CLIENT_TYPE=DSF
export CODEX_FEASIBILITY_BACKEND_CQL_TRANSLATE_ENABLED=true
cd ../dsf-broker
./start.sh $COMPOSE_PROJECT

cd ../flare
docker-compose -p $COMPOSE_PROJECT up -d

cd ../backend
docker-compose -p $COMPOSE_PROJECT up -d

cd ../gui
docker-compose -p $COMPOSE_PROJECT up -d


printf "Startup Num-Node components"
cd ../../num-node

cd flare
docker-compose -p $COMPOSE_PROJECT up -d

cd ../fhir-server/blaze-server
docker-compose -p $COMPOSE_PROJECT up -d

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT up -d

#cd ../aktin-client
#docker-compose -p $COMPOSE_PROJECT up -d

cd ../dsf-client
./start.sh $COMPOSE_PROJECT
