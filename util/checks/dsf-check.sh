#!/usr/bin/env bash

function fdpg_connection {
read -dr '' USAGE << EOF
Checks whether the connection to the FDPG can be established.

Usage: ./dsf-check fdpg-connection --cacert <PATH> --cert <PATH> --key <PATH> --connect-to <URL>
Flags:
    --cacert       Path to a PEM formatted file containing trusted CA certificates. Necessary when trying to connect to an FDPG instance serving a self-signed certificate.
    --cert         Path to a PEM formatted client certificate to authenticate yourself against the FDPG instance.
    --key          Path to a private key file associated with the client certificate to authenticate yourself against the FDPG instance.
    --connect-to   URL to an FDPG instance to run the check against. (Default: https://dsf.forschen-fuer-gesundheit.de/fhir)
EOF

CACERT=''
CERT=''
KEY=''
CONNECT_TO="https://dsf.forschen-fuer-gesundheit.de/fhir"

while test $# -gt 0; do
  case "$1" in
    --cacert)
        shift
        if test $# -gt 0; then
          export CACERT=$1
        else
          echo "No path to a file containing trusted CA certificates specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    --cert)
        shift
        if test $# -gt 0; then
          export CERT=$1
        else
          echo "No path to a client certificate specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    --key)
        shift
        if test $# -gt 0; then
          export KEY=$1
        else
          echo "No path to the private key, associated with the client certificate, specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    --connect-to)
        shift
        if test $# -gt 0; then
          CONNECT_TO=$1
        else
          echo "No URL target specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    help|--help|-h) echo "${USAGE}";;
    *)              echo "${USAGE}"; exit 1;;

  esac
done

COMMAND_FLAGS=""
if [[ -n "${CACERT}" ]]; then
  COMMAND_FLAGS="${COMMAND_FLAGS} --cacert ${CACERT}"
fi
if [[ -n "${CERT}" ]]; then
  COMMAND_FLAGS="${COMMAND_FLAGS} --cert ${CERT}"
fi
if [[ -n "${KEY}" ]]; then
  COMMAND_FLAGS="${COMMAND_FLAGS} --key ${KEY}"
fi
if [[ ! "${CONNECT_TO}" == */ ]]; then
  CONNECT_TO="${CONNECT_TO}/"
fi

STATUS_CODE=$(curl -s --write-out "%{http_code}" -H "Accept: application/fhir+json" "${COMMAND_FLAGS}" "${CONNECT_TO}"metadata)
if [[ ${STATUS_CODE} -ne 200 ]]; then
  echo "FAILED"
  exit 1
else
  echo "SUCCESS"
fi
}


function result {
read -dr '' USAGE << EOF
Gets the result of a specific query run from the FHIR inbox of a site (DIC). The query is uniquely identified by
the specified business key.

Usage: ./dsf-check result --cacert <PATH> --cert <PATH> --key <PATH> --connect-to <URL> --dic-identifier <STRING> business-key
Flags:
    --cacert          Path to a PEM formatted file containing trusted CA certificates. Necessary when trying to connect to an FDPG instance serving a self-signed certificate.
    --cert            Path to a PEM formatted client certificate to authenticate yourself against the FDPG instance.
    --key             Path to a private key file associated with the client certificate to authenticate yourself against the FDPG instance.
    --connect-to      URL to an FDPG instance to run the check against. (Default: https://dsf.forschen-fuer-gesundheit.de/fhir)
    --dic-identifier  DSF specific string for identifying a participating site (DIC).
EOF

CACERT=''
CERT=''
KEY=''
DIC_IDENTIFIER=''
CONNECT_TO="https://dsf.forschen-fuer-gesundheit.de/fhir"

while test $# -gt 0; do
  case "$1" in
    --cacert)
        shift
        if test $# -gt 0; then
          export CACERT=$1
        else
          echo "No path to a file containing trusted CA certificates specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    --cert)
        shift
        if test $# -gt 0; then
          export CERT=$1
        else
          echo "No path to a client certificate specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    --key)
        shift
        if test $# -gt 0; then
          export KEY=$1
        else
          echo "No path to the private key, associated with the client certificate, specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    --connect-to)
        shift
        if test $# -gt 0; then
          CONNECT_TO=$1
        else
          echo "No URL target specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    --dic-identifier)
        shift
        if test $# -gt 0; then
          DIC_IDENTIFIER=$1
        else
          echo "No DIC identifier specified."
          echo "${USAGE}"
          exit 1
        fi
        shift
        ;;
    help|--help|-h) echo "${USAGE}";;
    --*)            echo "${USAGE}"; exit 1;;
    *)
      BUSINESS_KEY=$1
      shift
      ;;
    
  esac
done

if [[ -z "${DIC_IDENTIFIER}" ]]; then
  echo "No DIC identifier specified."
  echo "${USAGE}"
  exit 1
fi

COMMAND_FLAGS=""
if [[ -n "${CACERT}" ]]; then
  COMMAND_FLAGS="${COMMAND_FLAGS} --cacert ${CACERT}"
fi
if [[ -n "${CERT}" ]]; then
  COMMAND_FLAGS="${COMMAND_FLAGS} --cert ${CERT}"
fi
if [[ -n "${KEY}" ]]; then
  COMMAND_FLAGS="${COMMAND_FLAGS} --key ${KEY}"
fi
if [[ ! "${CONNECT_TO}" == */ ]]; then
  CONNECT_TO="${CONNECT_TO}/"
fi

CORRELATING_TASK_URL=$(curl -s -H "Accept: application/fhir+json" "${COMMAND_FLAGS}" "${CONNECT_TO}Task?_sort=-_lastUpdated" | jq --arg bkey "${BUSINESS_KEY}" --arg dicid "${DIC_IDENTIFIER}" -r '.entry[] | select(.resource | .input[] | .type.coding[0].code == "business-key" and .valueString == $bkey) | select(.resource.requester.identifier.value == $dicid) | .fullUrl')

if [[ -z "${CORRELATING_TASK_URL}" ]]; then
  echo "Could not find a corresponding task."
  exit 2
fi

CORRELATING_TASK=$(curl -s -H "Accept: application/fhir+json" "${COMMAND_FLAGS}" "${CORRELATING_TASK_URL}")
TASK_ID=$(echo "${CORRELATING_TASK}" | jq -r .id)
TASK_STATUS=$(echo "${CORRELATING_TASK}" | jq -r .status)
MEASURE_REPORT_REF=$(echo "${CORRELATING_TASK}" | jq -r 'select(.input[] | .type.coding[0].code == "message-name" and .valueString == "feasibilitySingleDicResultMessage") | .input[] | select(.type.coding[0].code == "measure-report-reference") | .valueReference.reference')

if [[ -z "${MEASURE_REPORT_REF}" ]]; then
  echo "Could not find a corresponding measure report."
  exit 2
fi

MEASURE_REPORT=$(curl -s -H "Accept: application/fhir+json" "${COMMAND_FLAGS}" "${MEASURE_REPORT_REF}")
MEASURE_REPORT_ID=$(echo "${MEASURE_REPORT}" | jq -r .id)
MEASURE_REPORT_POPULATION_COUNT=$(echo "${MEASURE_REPORT}" | jq -r '.group[] | select(has("population")) | .population[] | select(.code.coding[0].code == "initial-population") | .count')

echo -e "Task ID: \t\t${TASK_ID}"
echo -e "Task Status: \t\t${TASK_STATUS}"
echo -e "Business Key: \t\t${BUSINESS_KEY}"
echo -e "Measure Report ID: \t${MEASURE_REPORT_ID}"
echo -e "Population Count: \t${MEASURE_REPORT_POPULATION_COUNT}"
}

# The main entrypoint of this script.
function entrypoint() {
read -rd '' USAGE << EOF
Command line utility to check a DSF installation.

Dependencies:
  curl  For running the actual requests. See https://github.com/curl/curl
  jq    For operating on data in JSON format. See https://github.com/stedolan/jq

Usage: ./dsf-check [command]
Commands are
    fdpg-connection   Checks whether the connection to the FDPG can be established.
    result            Checks results from a distributed query run for your site (DIC).
    help              Shows help for commands.
EOF

  case "$1" in
      fdpg-connection) fdpg_connection "${@:2}";;
      result)          result "${@:2}";;
      help|--help|-h)  echo "${USAGE}";;
      *)               echo "${USAGE}"; exit 1;;
  esac
}

entrypoint "${@:1}"
