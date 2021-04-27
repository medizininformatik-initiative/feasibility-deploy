#/bin/bash 

QUERY_INPUT=`cat`
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

RESP=$(bash execute-cql.sh "$QUERY_INPUT")

if [ $CLIENT_OBFUSCATE = true ]; then
  RESP=$(($RESP - ($RESP % 10) + 10))
fi