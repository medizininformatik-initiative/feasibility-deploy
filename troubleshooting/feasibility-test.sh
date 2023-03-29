#!/usr/bin/env bash

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
# FHIR_SERVER_URL=${FEASIBILITY_TEST_FHIR_SERVER_URL:-"http://localhost:8081/fhir"}
FLARE_SERVER_URL=${FEASIBILITY_TEST_FLARE_SERVER_URL:-"http://localhost:8084"}
TEST_FILES=("$BASE_DIR"/test-queries/*)
PRINT_SQ=${FEASIBILITY_TEST_PRINT_SQ:-true}

for testQuery in "${TEST_FILES[@]}"; do
  queryName=$(basename "$testQuery")
  printf "\n\nTest query = #################### %s ####################\n\n" "$queryName"

  printf "### Structured-Query file is:\n%s\n" "$testQuery"

  if [[ $PRINT_SQ == true ]];then
      printf "\n### Query input structured query :\n"
      cat "$testQuery"
  fi

  printf "\n### FLARE FHIR Search translation for query is: \n"
  curl --location --request POST "$FLARE_SERVER_URL/query/translate" \
  --header 'Content-Type: application/sq+json' \
  -d @"$testQuery"

  printf "\n\n### FLARE result (number of patients) for query is: \n"

  patientsFound=$(curl -s --location --request POST "$FLARE_SERVER_URL/query/execute" \
  --header 'Content-Type: application/sq+json' \
  -d @"$testQuery")

  if [[ "$patientsFound" == 0 ]];then
      printf "Found 0 patients, please check if this is correct for your server\n"
  else
      printf "Number of patients found for the query %s is: %s" "$queryName" "$patientsFound"
  fi
done
