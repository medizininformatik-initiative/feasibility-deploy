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

if [ $CLIENT_OBFUSCATE = true ]; then
  if [ $RESP -lt 5 ]; then
      RESP=0
  else
      OBFUSCATION_INTEGER=$(grep -m1 -ao '[0-10]' /dev/random | head -n1)
      OBFUSCATION_SIGN=$(grep -m1 -ao '[-+]' /dev/random)
      RESP=$(($RESP $OBFUSCATION_SIGN $OBFUSCATION_INTEGER - 5))
  fi
fi

echo "----BEGIN RESPONSE----" >> aktin-requests.log
echo $RESP >> aktin-requests.log
echo "----END RESPONSE----" >> aktin-requests.log

printf "$RESP"