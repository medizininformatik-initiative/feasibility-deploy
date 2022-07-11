#!/bin/sh 

QUERY_INPUT=`cat`
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

echo "##### INCOMING REQUEST at $(date) #####" >> aktin-requests.log
echo "----BEGIN REQUEST----" >> aktin-requests.log
echo $QUERY_INPUT >> aktin-requests.log
echo "----END REQUEST----" >> aktin-requests.log

RESP=$(sh execute-cql.sh "$QUERY_INPUT")

echo $RESP >> aktin-requests.log

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