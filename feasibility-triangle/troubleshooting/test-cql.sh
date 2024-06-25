#!/bin/bash -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

BASE="${1:-https://fhir.localhost:444/fhir}"
ACCESS_TOKEN="$2"

if ! command -v blazectl &> /dev/null
then
    echo "blazectl could not be found. please download it from https://github.com/samply/blazectl"
    exit 1
fi

if ! command -v jq &> /dev/null
then
    echo "jq could not be found. please install jq using your package manager or download it from https://jqlang.github.io/jq/download"
    exit 1
fi

evaluate_measure() {
  echo "Evaluate measure: $1..."
  OUTPUT="$(blazectl --server "$BASE" -k --token "$ACCESS_TOKEN" evaluate-measure "$SCRIPT_DIR/cql/$1.yml" 2> /dev/null)"
  REPORT="$(echo "$OUTPUT" | jq -f "$SCRIPT_DIR/cql/report.jq")"
  printf "Result: %d patients in %.3f s with %d of %d Bloom filters available\n\n" \
    "$(echo "$REPORT" | jq -r '.result')" \
    "$(echo "$REPORT" | jq -r '.duration')" \
    "$(echo "$REPORT" | jq -r '.bloomFilterStats.available')"\
    "$(echo "$REPORT" | jq -r '.bloomFilterStats.requested')"
}

evaluate_measure "1-Patient"
evaluate_measure "2-Condition"
evaluate_measure "3-Laboratory"
evaluate_measure "4-Procedure"
evaluate_measure "5-Consent"
evaluate_measure "6-Medication"
evaluate_measure "7-Specimen"

evaluate_measure "All"

if [[ -z "${ACCESS_TOKEN}" ]]
then
    printf "\n#####\n!\nNo access token was supplied - if your server requires an access token make sure you supply it\n"
    printf "Supply access token as second parameter to this script\n"
    printf "If your server is not protected ignore this message\n!\n#####\n\n"
fi
