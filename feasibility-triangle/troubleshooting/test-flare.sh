#!/bin/bash

FLARE_SERVER_URL=${FEASIBILITY_TEST_FLARE_SERVER_URL:-"http://localhost:8084"}
PRINT_SQ=${FEASIBILITY_TEST_PRINT_SQ:-true}
CHECK_TRANSLATION=${FEASIBILITY_TEST_CHECK_TRANSLATION:-true}
CHECK_EXECUTION=${FEASIBILITY_TEST_CHECK_EXECUTION:-true}

json_data=$(cat input-queries.json)
entries=$(echo "$json_data" | jq -r '.queries[] | @base64')

for entry in $entries; do
  decoded_entry=$(echo "$entry" | base64 -d)
  sq=$(echo "$decoded_entry" | jq -r '.sq')

  query_name=$(echo "$decoded_entry" | jq -r '."query-name"')

  printf "\n\nTest query = #################### %s ####################\n\n" "$query_name"

  if [[ $PRINT_SQ == true ]];then
      printf "\n### Query input structured query :\n"
      echo "$sq"
  fi

  if [[ $CHECK_TRANSLATION == true ]];then
      printf "\n### FLARE FHIR Search translation for query is: \n"
      curl --location "$FLARE_SERVER_URL/query/translate" \
      --header 'Content-Type: application/sq+json' \
      -d "$sq"
  fi

  if [[ $CHECK_EXECUTION == true ]];then
      printf "\n\n### FLARE FHIR Search execution result for query is: \n"
      curl --location "$FLARE_SERVER_URL/query/execute" \
      --header 'Content-Type: application/sq+json' \
      -d "$sq"
  fi

done
