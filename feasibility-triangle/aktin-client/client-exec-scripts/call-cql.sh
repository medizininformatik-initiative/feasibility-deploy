#!/bin/sh 

QUERY_INPUT=`cat`
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

echo "##### INCOMING REQUEST at $(date) #####" >> aktin-requests.log
echo "----BEGIN REQUEST----" >> aktin-requests.log
echo $QUERY_INPUT >> aktin-requests.log
echo "----END REQUEST----" >> aktin-requests.log

RESP=$(sh execute-cql.sh "$QUERY_INPUT")

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