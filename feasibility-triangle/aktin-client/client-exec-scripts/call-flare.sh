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

getObfuscatedResp() {
    OBFUSCATION_INTEGER=$(grep -m1 -ao '[0-5]' /dev/random | head -n1)
    OBFUSCATION_SIGN=$(grep -m1 -ao '[-+]' /dev/random)

    if [ $OBFUSCATION_INTEGER -eq 0 ] && [ $OBFUSCATION_SIGN == '-' ]; then
        getObfuscatedResp $1
    else
       echo $(($1 $OBFUSCATION_SIGN $OBFUSCATION_INTEGER))
    fi

}

if [ $CLIENT_OBFUSCATE == true ]; then
  RESP=$(getObfuscatedResp ${RESP})
  if [ $RESP -lt 5 ]; then
      RESP=""
  fi
fi

echo "----BEGIN RESPONSE----" >> aktin-requests.log
echo $RESP >> aktin-requests.log
echo "----END RESPONSE----" >> aktin-requests.log

printf "$RESP"