#!/bin/sh

BASE=${FHIR_BASE_URL:-"http://fhir-server:8080/fhir"}
BASIC_AUTH_64=$(echo -n "$AUTH_USER:$AUTH_PW" | base64)
BASIC_AUTH="Authorization: Basic $BASIC_AUTH_64"

library() {
cat <<END
{
  "resourceType": "Library",
  "status": "active",
  "type" : {
    "coding" : [
      {
        "code" : "logic-library"
      }
    ]
  },
  "content": [
    {
      "contentType": "text/cql"
    }
  ]
}
END
}

measure() {
cat <<END
{
  "resourceType": "Measure",
  "status": "active",
  "subjectCodeableConcept": {
    "coding": [
      {
        "system": "http://hl7.org/fhir/resource-types",
        "code": "Patient"
      }
    ]
  },
  "scoring": {
    "coding": [
      {
        "system": "http://terminology.hl7.org/CodeSystem/measure-scoring",
        "code": "cohort"
      }
    ]
  },
  "group": [
    {
      "population": [
        {
          "code": {
            "coding": [
              {
                "system": "http://terminology.hl7.org/CodeSystem/measure-population",
                "code": "initial-population"
              }
            ]
          },
          "criteria": {
            "language": "text/cql",
            "expression": "InInitialPopulation"
          }
        }
      ]
    }
  ]
}
END
}

createlibrary() {
  library | jq -cM ".url = \"urn:uuid:$1\" | .content[0].data = \"$2\""
}


createmeasure() {
  measure | jq -cM ".url = \"urn:uuid:$1\" | .library[0] = \"urn:uuid:$2\" | .subjectCodeableConcept.coding[0].code = \"$3\""
}

post() {
  if [[ -n "$AUTH_USER" && -n "$AUTH_PW" ]];
  then
    curl -sH "Content-Type: application/fhir+json" -H "$BASIC_AUTH" -d @- "${BASE}/$1"
  else
    curl -sH "Content-Type: application/fhir+json" -d @- "${BASE}/$1"
  fi
}

evaluatemeasure() {
  if [[ -n "$AUTH_USER" && -n "$AUTH_PW" ]];
  then
    curl -s -H "$BASIC_AUTH" "${BASE}/Measure/$1/\$evaluate-measure?periodStart=2000&periodEnd=2099"
  else
    curl -s "${BASE}/Measure/$1/\$evaluate-measure?periodStart=2000&periodEnd=2099"
  fi
}

TYPE="Patient"
DATA=$( echo "$1" | base64 | tr -d '\n')

LIBRARY_URI=$(uuidgen | tr '[:upper:]' '[:lower:]')
MEASURE_URI=$(uuidgen | tr '[:upper:]' '[:lower:]')

createlibrary "${LIBRARY_URI}" "${DATA}" | post "Library" > /dev/null

MEASURE_ID=$(createmeasure "${MEASURE_URI}" "${LIBRARY_URI}" "${TYPE}" | post "Measure" | jq -r .id)

COUNT=$(evaluatemeasure "${MEASURE_ID}" | jq ".group[0].population[0].count")

echo -n "${COUNT}"
