#!/bin/bash -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

BASE="${1:-https://fhir.localhost:444/fhir}"
ACCESS_TOKEN="$2"

evaluate_measure() {
  echo "Evaluate measure: $1..."
  OUTPUT="$(blazectl --server "$BASE" -k --token "$ACCESS_TOKEN" evaluate-measure "$SCRIPT_DIR/cql/$1.yml" 2> /dev/null)"
  REPORT="$(echo "$OUTPUT" | jq -f "$SCRIPT_DIR/cql/report.jq")"
  echo $OUTPUT
  printf "Result: %d patients in %.3f s with %d of %d Bloom filters available\n\n" \
    "$(echo "$REPORT" | jq -r '.result')" \
    "$(echo "$REPORT" | jq -r '.duration')" \
    "$(echo "$REPORT" | jq -r '.bloomFilterStats.available')"\
    "$(echo "$REPORT" | jq -r '.bloomFilterStats.requested')"
}

evaluate_measure "1-Patient"
evaluate_measure "2-Condition"
evaluate_measure "3-Labor"
evaluate_measure "4-Prozedur"
evaluate_measure "5-Konsent"
evaluate_measure "6-Medikation"
evaluate_measure "7-Specimen"

evaluate_measure "All"
