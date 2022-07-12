#!/bin/sh 

FLARE_BASE_URL=${FLARE_BASE_URL:-"http://flare:8080"}
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

QUERY_INPUT=`cat`

echo "##### INCOMING REQUEST at $(date) #####" >> aktin-requests.log
echo "----BEGIN REQUEST----" >> aktin-requests.log
echo $QUERY_INPUT >> aktin-requests.log
echo "----END REQUEST----" >> aktin-requests.log

RESP=$(curl --location --request POST "$FLARE_BASE_URL/query/execute" \
--header 'Content-Type: application/sq+json' \
--data-raw "$QUERY_INPUT")

if [ "$CLIENT_OBFUSCATE" = true ]; then
  OBFUSCATION_INTEGER=$(($RANDOM % 11 - 5))
  RESP=$(($RESP + $OBFUSCATION_INTEGER))
  if [ $RESP -lt 5 ]; then
      RESP=0
  fi
fi

echo "----BEGIN RESPONSE----" >> aktin-requests.log
echo $RESP >> aktin-requests.log
echo "----END RESPONSE----" >> aktin-requests.log

printf "$RESP"