#!/bin/sh

QUERY_INPUT=$(cat)
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

{
  echo "##### INCOMING REQUEST at $(date) #####"
  echo "----BEGIN REQUEST----"
  echo "$QUERY_INPUT"
  echo "----END REQUEST----"
} >> aktin-requests.log

RESP=$(sh execute-cql.sh "$QUERY_INPUT")

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
