#/bin/bash 

FLARE_BASE_URL=${FLARE_BASE_URL:-"http://flare:8080"}
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

QUERY_INPUT=`cat`

echo "##### INCOMING REQUEST at $(date) #####" >> aktin-requests.log
echo "----BEGIN REQUEST----" >> aktin-requests.log
echo $QUERY_INPUT >> aktin-requests.log
echo "----END REQUEST----" >> aktin-requests.log

RESP=$(curl --location --request POST "$FLARE_BASE_URL/flare/query/execute" \
--header 'Accept-Encoding: CSQ' \
--header 'Content-Type: application/json' \
--data-raw "$QUERY_INPUT")

if [ $CLIENT_OBFUSCATE = true ]; then
  if [ $RESP != 0 ];then
    RESP=$(($RESP - ($RESP % 10) + 10))
  fi
fi

echo "----BEGIN RESPONSE----" >> aktin-requests.log
echo $RESP >> aktin-requests.log
echo "----END RESPONSE----" >> aktin-requests.log

printf "$RESP"