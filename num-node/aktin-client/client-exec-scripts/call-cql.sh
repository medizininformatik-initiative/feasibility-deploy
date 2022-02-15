#/bin/bash 

QUERY_INPUT=`cat`
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

echo "##### INCOMING REQUEST at $(date) #####" >> aktin-requests.log
echo "----BEGIN REQUEST----" >> aktin-requests.log
echo $QUERY_INPUT >> aktin-requests.log
echo "----END REQUEST----" >> aktin-requests.log

RESP=$(sh execute-cql.sh "$QUERY_INPUT")

if [ $CLIENT_OBFUSCATE = true ]; then
  RESP=$(($RESP - ($RESP % 10) + 10))
fi

echo "----BEGIN RESPONSE----" >> aktin-requests.log
echo $RESP >> aktin-requests.log
echo "----END RESPONSE----" >> aktin-requests.log

printf "$RESP"