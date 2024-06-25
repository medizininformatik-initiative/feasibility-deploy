#!/bin/bash -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

BASE_DSF_FHIR="${1:-}"
LAST_UPDATE="${2:-}"
DSF_CERT_PATH="${3:-}"
DSF_KEY_PATH="${4:-}"
PRINT_CCDL="${5:-true}"
PRINT_CQL="${6:-true}"

exec_query() {
  curl -X GET -s \
  --cert "$DSF_CERT_PATH" \
  --key "$DSF_KEY_PATH" \
  -H "Accept: application/json" \
  $1

}

printf "## Getting last feasibility Task from server: $BASE_DSF_FHIR\n"

LAST_FEASIBILITY_TASK=$(exec_query "$BASE_DSF_FHIR/Task?_profile=http://medizininformatik-initiative.de/fhir/StructureDefinition/feasibility-task-execute|1.0&_format=json&_lastUpdated=2024-06-03T08:48:25.476+02:00")
MEASURE_REF=$(echo "$LAST_FEASIBILITY_TASK" | jq -r ".entry[0].resource.input[]|select(.type.coding[0].code==\"measure-reference\").valueReference.reference")

printf "## Resolving Measure Reference from last task and extracting library link\n"

MEASURE=$(exec_query "$MEASURE_REF")

LIBRARY_SERVER_DOMAIN=$(echo "$MEASURE_REF" | awk -F/ '{print $3}')
LIBRARY_URL=$(echo "$MEASURE" | jq -r .library[0])

printf "## Resolving Library link and extracting content CQL and CCDL\n"

LIBRARY=$(exec_query "https://$LIBRARY_SERVER_DOMAIN/fhir/Library?url=$LIBRARY_URL")

LIB_CQL=$(echo "$LIBRARY" | jq -r ".entry[0].resource.content[]|select(.contentType==\"text/cql\").data")
LIB_CCDL=$(echo "$LIBRARY" | jq -r ".entry[0].resource.content[]|select(.contentType==\"application/json\").data")

CCDL=$(echo "$LIB_CCDL" | base64 --decode)
CQL=$(echo "$LIB_CQL" | base64 --decode)


if [[ $PRINT_CCDL == true ]];then
    printf "\n### Last CCDL recieved:\n"
    echo "$CCDL" | jq .
fi

if [[ $PRINT_CQL == true ]];then
    printf "\n### Last CQL recieved:\n"
    echo "$CQL"
fi
