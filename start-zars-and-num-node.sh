#!/bin/sh

# Globals
COMPOSE_PROJECT=codex-deploy

# Option Defaults
MIDDLEWARE_TYPE=AKTIN
FHIR_SERVER_TYPE=BLAZE

usage() {
  cat <<USAGE
usage: $(basename $0) [flags]

The following flags are available:
    --with-middleware-type=AKTIN     the middleware type to use (AKTIN or DSF)
    --with-fhir-server-type=$FHIR_SERVER_TYPE    the FHIR server to use (BLAZE or HAPI)
USAGE
}

for opt in "$@"; do
  case $opt in
  --with-middleware-type=*)
    MIDDLEWARE_TYPE=$(echo "${opt#*=}" | tr '[:lower:]' '[:upper:]')
    if [ "$MIDDLEWARE_TYPE" != "AKTIN" ] && [ "$MIDDLEWARE_TYPE" != "DSF" ]; then
      echo "Unknown middleware type: $MIDDLEWARE_TYPE".
      usage
      exit 1
    fi
    shift
    ;;
  --with-fhir-server-type=*)
    FHIR_SERVER_TYPE=$(echo "${opt#*=}" | tr '[:lower:]' '[:upper:]')
    if [ "$FHIR_SERVER_TYPE" != "BLAZE" ] && [ "$FHIR_SERVER_TYPE" != "HAPI" ]; then
      echo "Unknown FHIR server type: $FHIR_SERVER_TYPE".
      usage
      exit 1
    fi
    shift
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  *) shift ;;
  esac
done

# Configuration ---------------------------------------------------------------
export CODEX_FEASIBILITY_BACKEND_BROKER_CLIENT_TYPE=$MIDDLEWARE_TYPE

# Execution -------------------------------------------------------------------
printf "Startup ZARS components ..."
cd zars

cd keycloak
docker-compose -p $COMPOSE_PROJECT up -d

if [ "$MIDDLEWARE_TYPE" = "AKTIN" ]; then
  cd ../aktin-broker
  docker-compose -p $COMPOSE_PROJECT up -d
else
  export CODEX_FEASIBILITY_BACKEND_CQL_TRANSLATE_ENABLED=true
  cd ../dsf-broker
  ./start.sh $COMPOSE_PROJECT
fi

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

if [ "$FHIR_SERVER_TYPE" = "BLAZE" ]; then
  cd ../fhir-server/blaze-server
  docker-compose -p $COMPOSE_PROJECT up -d
else
  cd ../fhir-server/hapi-fhir-server
  docker-compose -p $COMPOSE_PROJECT up -d
fi

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT up -d

if [ "$CODEX_FEASIBILITY_BACKEND_BROKER_CLIENT_TYPE" = "AKTIN" ]; then
  cd ../aktin-client
  docker-compose -p $COMPOSE_PROJECT up -d
else
  cd ../dsf-client
  ./start.sh $COMPOSE_PROJECT
fi
