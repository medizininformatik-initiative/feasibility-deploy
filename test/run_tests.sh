#!/bin/bash
set -o pipefail

RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
BOLD=$(tput bold)
UNDERLINE=$(tput smul)
RESET=$(tput sgr 0)

check_ignored() {
  for ignored in $ignored_files; do
    if [ "$1" == "$ignored" ]; then
      return 0
    fi
  done
  return 1
}

print_info() {
  echo -n "    ${UNDERLINE}$1${RESET}:  "
  echo "$2"
}

print_success() {
  echo "$GREEN SUCCESS$RESET"
  while ! { [[ -z "$1" ]] || [[ -z "$2" ]]; }; do
    print_info "$1" "$2"
    shift 2
  done
}

print_fail() {
  echo "$RED FAILURE $RESET"
  while ! { [[ -z "$1" ]] || [[ -z "$2" ]]; }; do
    print_info "$1" "$2"
    shift 2
  done
  case_fail=$((case_fail+1))
}

for e in "AUTH_TOKEN_REQUEST_URL" "AUTH_USERNAME" "AUTH_PASSWORD" "QUERY_ENDPOINT_URL" "TEST_DATA_PATH"; do
  missing=false
  if [ -z "${!e}" ]; then
    echo "${RED}Required environment variable '$e' missing!${RESET}"
    missing=true
  fi
done

if $missing; then
  exit 1
fi

mapfile -t files < <(ls "$TEST_DATA_PATH"/testCases/*.json)
ignored_files=$(cat "$TEST_DATA_PATH"/testCaseIgnoreList.txt)
case_total="${#files[@]}"
case_execute=0
case_fail=0
case_ignore=0
pad=${#case_total}
delay=${TEST_RETRY_DELAY:-2}
i=0

for f in "${files[@]}"; do
  filename="$(basename "$f")"
  title="$(echo "$filename" | sed -r 's/\.json//')"
  if check_ignored "$filename"; then
    continue
  fi
  case_execute=$((case_execute+1))
done

for f in "${files[@]}"; do
  filename="$(basename "$f")"
  title="$(echo "$filename" | sed -r 's/\.json//')"

  if check_ignored "$filename"; then
    case_ignore=$((case_ignore+1))
    continue
  fi

  i=$((i+1))

  echo ""
  printf "${BOLD}[%${pad}s/%d] Running Test Case:$RESET %s\n" "$i" "$case_execute" "$title"
  echo -n "  Sending Query      "
  auth_token="$(curl -ksS --location --request POST "$AUTH_TOKEN_REQUEST_URL" \
                            --header 'Content-Type: application/x-www-form-urlencoded' \
                           --data-urlencode 'grant_type=password' \
                           --data-urlencode "username=$AUTH_USERNAME" \
                           --data-urlencode "password=$AUTH_PASSWORD" \
                           --data-urlencode 'client_id=feasibility-gui' 2>&1)"
  if ! jq -ne --argjson auth "$auth_token" '$auth | .access_token != null' 1> /dev/null 2>&1; then
    print_fail "Error" "${RED}Response to access token request does not conform to expected format${RESET}" "Response" "$auth_token"
    continue
  fi
  auth_token="$(jq -rn --argjson auth "$auth_token" '$auth | .access_token')"
  result_location="$(curl -ksS --location --request POST\
                                 --header 'Content-Type: application/json' \
                                 --header 'Accept: application/json' \
                                 --header "Authorization: Bearer $auth_token" \
                                 --data "@$f" \
                                 "$QUERY_ENDPOINT_URL")"
  if ! jq -ne --argjson result "$result_location" '$result | .location != null' 1> /dev/null 2>&1; then
    print_fail "Error" "${RED}Query response does not conform to expected format${RESET}" "Query File" "$f" "Response" "$result_location"
    continue
  fi
  result_location="$(jq -rn --argjson result "$result_location" '$result | .location')"
  print_success "Send Query" "Success"

  echo -n "  Retrieving Result  "
  retries=${TEST_RETRY_COUNT:-5}
  failed=true
  while [ "$retries" -gt 0 ]; do
    result="$(curl -ksS --location \
                         --header "Authorization: Bearer $auth_token" \
                         --header 'Accept: application/json' \
                         "$result_location")"
    if ! jq -ne --argjson result "$result" '$result | .resultLines != null' 1> /dev/null 2>&1; then
      print_fail "Error" "${RED}Result response does not conform to expected format${RESET}" "Response" "$result"
      continue
    fi
    if jq -ne --argjson result "$result" '$result | .resultLines | length > 0' 1> /dev/null 2>&1; then
      failed=false
      break
    fi
    sleep "$delay"
    retries=$((retries-1))
  done

  if $failed; then
    print_fail "Error" "${RED}Result response contains empty resultLines${RESET}" "Result Location" "$result_location" "Response" "$result"
    continue
  fi

  if ! jq -ne --argjson result "$result" '$result | .totalNumberOfPatients == 1' 1> /dev/null 2>&1; then
    print_fail "Expected Result" "1" "Actual Result" "$(jq -n --argjson result "$result" '$result | .totalNumberOfPatients')"
    continue
  else
    print_success "Query Result" "Success"
  fi
done

echo ""
echo "${BOLD}Test Summary:${RESET}"
echo "  ${UNDERLINE}Total${RESET}:       $case_total"
printf "  ${UNDERLINE}Ignored${RESET}:     ${YELLOW}%${pad}s${RESET}\n" "$case_ignore"
printf "  ${UNDERLINE}Executed${RESET}:    %${pad}s\n" "$case_execute"
printf "  ${UNDERLINE}Succeeded${RESET}:   ${GREEN}%${pad}s${RESET}\n" "$((case_execute-case_fail))"
echo -n "  ${UNDERLINE}Failed${RESET}:      "
if [ $case_fail -gt 0 ]; then
  printf "${RED}%${pad}s${RESET}\n" "$case_fail"
  exit 1
else
  printf "${GREEN}%${pad}s${RESET}\n" "0"
  exit 0
fi
