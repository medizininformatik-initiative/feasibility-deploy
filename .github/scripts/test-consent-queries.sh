#!/bin/bash -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
. "$SCRIPT_DIR/util.sh"

BASE="http://localhost:8081/fhir"
PERMIT_URI="$BASE/Consent?mii-provision-provision-code-type=2.16.840.1.113883.3.1937.777.24.5.1.1\$permit"
DENY_URI="$BASE/Consent?mii-provision-provision-code-type=2.16.840.1.113883.3.1937.777.24.5.1.1\$deny"

count() {
  RESP=$(curl -sH 'Prefer: handling=strict' -H 'Accept: application/fhir+json' "$1")

  if [ "$(echo "$RESP" | jq -r .resourceType)" = "OperationOutcome" ]; then
    echo "$RESP" | jq -r .issue[].diagnostics
  else
    echo "$RESP" | jq -r .total
  fi
}

test "permit count" "$(count "$PERMIT_URI")" "1"
test "permit count" "$(count "$DENY_URI")" "0"
