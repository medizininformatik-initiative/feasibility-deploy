#!/bin/sh

# Globals
COMPOSE_PROJECT=codex-deploy

# Option Defaults
MIDDLEWARE_TYPE=AKTIN

usage() {
  cat <<USAGE
usage: $(basename $0) [flags]

The following flags are available:
    --with-middleware-type=AKTIN     the middleware type to use (AKTIN or DSF)
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

cd ../fhir-server/blaze-server
docker-compose -p $COMPOSE_PROJECT up -d

cd ../../rev-proxy
docker-compose -p $COMPOSE_PROJECT up -d

if [ "$CODEX_FEASIBILITY_BACKEND_BROKER_CLIENT_TYPE" = "AKTIN" ]; then
  cd ../aktin-client
  docker-compose -p $COMPOSE_PROJECT up -d
else
  cd ../dsf-client
  ./start.sh $COMPOSE_PROJECT
fi
