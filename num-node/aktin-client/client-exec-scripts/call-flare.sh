#/bin/bash 

FLARE_BASE_URL=${FLARE_BASE_URL:-"http://flare:5000"}
CLIENT_OBFUSCATE=${CLIENT_OBFUSCATE:-true}

QUERY_INPUT=`cat`

RESP=$(curl --location --request POST "$FLARE_BASE_URL/query-sync" \
--header 'Content-Type: codex/json' \
--header 'Accept: internal/json' \
--data-raw "$QUERY_INPUT")

if [ $CLIENT_OBFUSCATE = true ]; then
  RESP=$(($RESP - ($RESP % 10) + 10))
fi

printf "$RESP"