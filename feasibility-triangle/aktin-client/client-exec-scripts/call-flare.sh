#!/bin/sh

FLARE_BASE_URL=${FLARE_BASE_URL:-"http://flare:8080"}
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

QUERY_INPUT=$(cat)

{
  echo "##### INCOMING REQUEST at $(date) #####"
  echo "----BEGIN REQUEST----"
  echo "$QUERY_INPUT"
  echo "----END REQUEST----"
} >> aktin-requests.log

RESP=$(curl --location --request POST "$FLARE_BASE_URL/query/execute" \
--header 'Content-Type: application/sq+json' \
--data-raw "$QUERY_INPUT")

if [ "$CLIENT_OBFUSCATE" = true ]; then
  OBFUSCATION_INTEGER=$((RANDOM % 11 - 5))
  RESP=$((RESP + OBFUSCATION_INTEGER))
  if [ "$RESP" -lt 5 ]; then
      RESP=0
  fi
fi

{
  echo "----BEGIN RESPONSE----"
  echo "$RESP"
  echo "----END RESPONSE----"
} >> aktin-requests.log

echo -n "$RESP"
