#!/bin/sh

# Globals
COMPOSE_PROJECT=codex-deploy

# Option Defaults
MIDDLEWARE_TYPE=AKTIN
FHIR_SERVER_TYPE=BLAZE
QUERY_FORMAT=STRUCTURED
OBFUSCATE=true

usage() {
  cat <<USAGE
usage: $(basename $0) [flags]

The following flags are available:
    --with-middleware-type=AKTIN     the middleware type to use (AKTIN or DSF)
    --with-fhir-server-type=BLAZE    the FHIR server to use (BLAZE or HAPI)
    --with-query-format=STRUCTURED   format used for the queries (STRUCTURED or CQL)
    --disable-result-obfuscation     disabled the result obfuscation
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
  --with-query-format=*)
    QUERY_FORMAT=$(echo "${opt#*=}" | tr '[:lower:]' '[:upper:]')
    if [ "$QUERY_FORMAT" != "STRUCTURED" ] && [ "$QUERY_FORMAT" != "CQL" ]; then
      echo "Unknown query format: $QUERY_FORMAT".
      usage
      exit 1
    fi
    shift
    ;;
  --disable-obfuscation)
    OBFUSCATE=false
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
if [ "$QUERY_FORMAT" = "CQL" ]; then
  export CODEX_FEASIBILITY_BACKEND_CQL_TRANSLATE_ENABLED=true
  export CODEX_FEASIBILITY_AKTIN_CLIENT_BROKER_REQUEST_MEDIATYPE=text/cql
  export CODEX_FEASIBILITY_AKTIN_CLIENT_PROCESS_COMMAND=/opt/codex-aktin/call-cql.sh
  export CODEX_FEASIBILITY_DSF_CLIENT_PROCESS_EVALUATION_STRATEGY=cql
else
  export CODEX_FEASIBILITY_BACKEND_CQL_TRANSLATE_ENABLED=false
  export CODEX_FEASIBILITY_AKTIN_CLIENT_BROKER_REQUEST_MEDIATYPE=application/sq+json
  export CODEX_FEASIBILITY_AKTIN_CLIENT_PROCESS_COMMAND=/opt/codex-aktin/call-flare.sh
  export CODEX_FEASIBILITY_DSF_CLIENT_PROCESS_EVALUATION_STRATEGY=structured-query
fi

if [ "$MIDDLEWARE_TYPE" = "DSF" ]; then
  # Always required by DSF alongside the "Structured Query" format even though it is not used for evaluation.
  export CODEX_FEASIBILITY_BACKEND_CQL_TRANSLATE_ENABLED=true
fi

if [ "$OBFUSCATE" = true ]; then
  export CODEX_FEASIBILITY_AKTIN_CLIENT_OBFUSCATE=true
  export CODEX_FEASIBILITY_DSF_CLIENT_PROCESS_EVALUATION_OBFUSCATE=true
else
  export CODEX_FEASIBILITY_AKTIN_CLIENT_OBFUSCATE=false
  export CODEX_FEASIBILITY_DSF_CLIENT_PROCESS_EVALUATION_OBFUSCATE=false
fi

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

if [ "$MIDDLEWARE_TYPE" = "AKTIN" ] || { [ "$MIDDLEWARE_TYPE" = "DSF" ] && [ "$QUERY_FORMAT" = "STRUCTURED" ]; }; then
  cd flare
  docker-compose -p $COMPOSE_PROJECT up -d
fi

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
