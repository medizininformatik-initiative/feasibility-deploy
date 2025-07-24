#!/bin/bash -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
. "$SCRIPT_DIR/util.sh"

BASE="$1"
TOKEN="$2"
CACERT="$3"
PERMIT_URI="$BASE/Consent?mii-provision-provision-code-type=2.16.840.1.113883.3.1937.777.24.5.3.6\$permit"
CONDITION_URI="$BASE/Condition?code=http://fhir.de/CodeSystem/bfarm/icd-10-gm|B05.3"

count() {
  RESP=$(curl -sH 'Prefer: handling=strict' -H 'Accept: application/fhir+json' -H "Authorization: Bearer $TOKEN" --cacert "$CACERT" "$1")

  if [ "$(echo "$RESP" | jq -r .resourceType)" = "OperationOutcome" ]; then
    echo "$RESP" | jq -r .issue[].diagnostics
  else
    echo "$RESP" | jq -r .total
  fi
}

test "permit count" "$(count "$PERMIT_URI")" "3"
test "Condition count" "$(count "$CONDITION_URI")" "1"