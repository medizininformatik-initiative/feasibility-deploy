#!/bin/bash
set -o pipefail

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BOLD=$(tput bold)
UNDERLINE=$(tput smul)
RESET=$(tput sgr 0)

case_total=$(ls $TEST_DATA_PATH/testCases/*.json | wc -l)
case_fail=0
pad=${#case_total}
i=1

for t in $TEST_DATA_PATH/testCases/*.json; do
  title="$(basename "$t" | sed -r 's/\.json//')"
  echo ""
  printf "${BOLD}[%${pad}s/%d] Running Test Case:$RESET %s\n" "$i" "$case_total" "$title"
  i=$((i+1))
  echo -n "  Request Access Token  "
  auth_token="$(curl -ksS --location --request POST 'https://localhost:8443/auth/realms/codex-develop/protocol/openid-connect/token' \
                            --header 'Content-Type: application/x-www-form-urlencoded' \
                           --data-urlencode 'grant_type=password' \
                           --data-urlencode 'username=codex-developer' \
                           --data-urlencode "password=$AUTH_PASSWORD" \
                           --data-urlencode 'client_id=feasibility-gui' 2>&1)"
  if ! jq -ne --argjson auth "$auth_token" '$auth | .access_token != null' 1> /dev/null 2>&1; then
    echo "$RED FAILURE $RESET"
    echo "  ${UNDERLINE}Response:$RESET"
    echo $auth_token
    case_fail=$((case_fail+1))
    continue
  fi
  auth_token="$(jq -rn --argjson auth "$auth_token" '$auth | .access_token')"
  echo "$GREEN SUCCESS$RESET"

  echo -n "  Sending Query         "
  query="$(jq -r "." $t)"
  result_location="$(curl -ksS --location --request POST\
                                 --header 'Content-Type: application/json' \
                                 --header 'Accept: application/json' \
                                 --header "Authorization: Bearer $auth_token" \
                                 --data "@$t" \
                                 'http://localhost:8091/api/v1/query-handler/run-query')"
  if ! jq -ne --argjson result "$result_location" '$result | .location != null' 1> /dev/null 2>&1; then
    echo "$RED FAILURE$RESET"
    echo "  ${UNDERLINE}Query:$RESET"
    jq '.' $t
    echo "  ${UNDERLINE}Response:$RESET"
    echo $result_location
    case_fail=$((case_fail+1))
    continue
  fi
  result_location="$(jq -rn --argjson result "$result_location" '$result | .location')"
  echo "$GREEN SUCCESS$RESET"

  echo -n "  Querying Result       "
  retries=10
  while [ $retries -gt 0 ]; do
    result="$(curl -ksS --location \
                         --header "Authorization: Bearer $auth_token" \
                         --header 'Accept: application/json' \
                         "$result_location")"
    if ! jq -ne --argjson result "$result" '$result | .resultLines != null' 1> /dev/null 2>&1; then
      echo "$RED FAILURE$RESET"
      echo "  ${UNDERLINE}Response:$RESET"
      echo $result
      case_fail=$((case_fail+1))
      continue
    fi
    if jq -ne --argjson result "$result" '$result | .resultLines | length > 0' 1> /dev/null 2>&1; then
      break
    fi
    sleep 1
    retries=$((retries-1))
  done

  if ! jq -ne --argjson result "$result" '$result | .totalNumberOfPatients == 1' 1> /dev/null 2>&1; then
    echo "$RED FAILURE$RESET"
    echo "  ${UNDERLINE}Response:$RESET"
    echo $result
    case_fail=$((case_fail+1))
    continue
  fi

  echo "$GREEN SUCCESS$RESET"
done

echo ""
echo "${BOLD}Summary:${RESET}"
echo "  ${UNDERLINE}Total:${RESET}    $case_total"
printf "  ${UNDERLINE}Succeded:${RESET}${GREEN} %${pad}s${RESET}\n" "$((case_total-case_fail))"
echo -n "  ${UNDERLINE}Failed:${RESET}   "
if [ $case_fail -gt 0 ]; then
  printf "${RED}%${pad}s${RESET}\n" "$case_fail"
  exit 1
else
  printf "${GREEN}%${pad}s${RESET}\n" "$case_fail"
  exit 0
fi
