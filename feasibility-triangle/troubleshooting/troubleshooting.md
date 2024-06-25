# Troubleshooting Feasibility Triangle

The feasibility triangle can be composed of the following components.
To debug your triangle it is important that you check each component, starting with the last component in the queue
and working your way towards the Middleware, which connects to the central portal.

1. DSF - FLARE (FHIR Search) - FHIR Server (not CQL ready)
2. DSF - FHIR Server (CQL ready)

=> Debugging Route

1. FHIR Server -> FLARE check translate ->  FLARE check execute -> DSF
2. FHIR Server -> CQL check execution -> DSF


Additionally you can use the FLARE tool to check if your data is loaded into the FHIR server correctly.
See DQA below.

For our monitoring we currently use the queries specified here <https://github.com/medizininformatik-initiative/feasibility-monitoring>
in the `input-queries.json` file. These will be updated regularly to reflect the newest tests and implemented FHIR modules.

> **Before running any tests update the test queries by executing `bash update-test-queries.sh`**


## Communicating problems

If you encounter a problem with any of the components and you have identified in which component the error occurs please create an issue for the respective component directly:
Blaze: <https://github.com/samply/blaze>
FLARE: <https://github.com/medizininformatik-initiative/flare>
DSF: <https://github.com/medizininformatik-initiative/feasibility-dsf-process> 

If you cannot place the error directly use this repository to create an issue:
<https://github.com/medizininformatik-initiative/feasibility-deploy>

## FHIR Server

Check if your FHIR server is running. In the default installation execute `curl -H "Authorization: Bearer <your-token-here - get with get-fhir-server-access-token.sh of this repo>"  "http://localhost:8081/fhir/Patient?_summary=count"`
T
his should return a result as follows:

```
{"id":"DCCM7GJX6LIW2SIL","type":"searchset","total":12040,"link":[{"relation":"self","url":"http://localhost:8081/fhir/Patient?_summary=count&_count=50&__t=12041"}],"resourceType":"Bundle"}
```

If this does not return a result check the logs of your fhir server, for default setup `docker logs -f feasibility-deploy_fhir-server_1`
and contact our team or create an issue here: https://github.com/samply/blaze

Note: If you have a FHIR server other than Blaze please contact the appropriate vendor or support team.

## CQL Execution

CQL queries are directly executed on your FHIR server and do not require any additional tooling like FLARE.

To test standard cql queries from the monitoring used at the time of this release execute the `test-cql.sh` in this folder.

Note that this requires you to install blazectl <https://github.com/samply/blazectl> and jq <https://jqlang.github.io/jq/> on your server.

Further the new version of blaze requires you to use an access token to access it in the default and recommended installation. To get an access token to pass to the `test-cql.sh` script use the `get-fhir-server-access-token.sh` of this repo.

You can also get the newest CQL and CCDL query recieved via your DSF, by using the `get-last-queries-from-dsf.sh` of this repository.


## FLARE

To see if FLARE is running use `docker ps` to list all your containers currently running.
There should be one container called: feasibility-deploy_flare_1

If it is running your can see its logs by using: `docker logs -f feasibility-deploy_flare_1`

Before running any tests update the test queries by executing `bash update-test-queries.sh`

If this does not work try to download the input-queries test file from github: <https://raw.githubusercontent.com/medizininformatik-initiative/feasibility-monitoring/main/input-queries.json>

To check if FLARE has the right ontology loaded and can execute the SQs from input-quries.json on your FHIR server, execute:
```bash
export FEASIBILITY_TEST_CHECK_TRANSLATION=true
export FEASIBILITY_TEST_CHECK_EXECUTION=true
bash test-flare.sh
```

### FLARE - Check translate Only

To check if FLARE has the right ontology loaded and FLARE can translate the SQs from input-queries.json, execute:

```bash
export FEASIBILITY_TEST_CHECK_TRANSLATION=true
export FEASIBILITY_TEST_CHECK_EXECUTION=false
bash test-flare.sh
```


### FLARE - Check execute Only

To check if FLARE is configured correctly, can connect to the FHIR server and execute the SQs from input-queries.json, execute:

```bash
export FEASIBILITY_TEST_CHECK_TRANSLATION=false
export FEASIBILITY_TEST_CHECK_EXECUTION=true
bash test-flare.sh
```

### FLARE - Check translate (manual)

To check if the translation is correct and you have updated to the correct ontology mapping files,
you can access the flare component directly:

Flare has a translation endpoint /translate, which allows you to get the fhir search representation of a request:

```
curl --location --request POST 'http://localhost:8084/query/translate' \
--header 'Content-Type: application/sq+json' \
--data-raw '<your-CCDL-here>'
```

> **Note**: 
> You can create a feasibility query in the UI <https://feasibility.forschen-fuer-gesundheit.de/> and use the Download function under "save > > query" to download a current CCDL to test.

This will give you an output, which contains the fhir search translation for each criterion in our Structured-Query, for example:

The CCDL:
```
curl --location --request POST 'http://localhost:8084/query/tranlsate' \
--header 'Content-Type: application/sq+json' \
--data-raw '{
        "version": "http://to_be_decided.com/draft-1/schema#",
        "display": "",
        "inclusionCriteria": [
          [
            {
              "termCodes": [
                {
                  "code": "263495000",
                  "system": "http://snomed.info/sct",
                  "display": "Geschlecht"
                }
              ],
              "context": {
                "code": "Patient",
                "system": "fdpg.mii.cds",
                "version": "1.0.0",
                "display": "Patient"
              },
              "valueFilter": {
                "selectedConcepts": [
                  {
                    "code": "female",
                    "display": "Female",
                    "system": "http://hl7.org/fhir/administrative-gender"
                  },
                  {
                    "code": "male",
                    "display": "Male",
                    "system": "http://hl7.org/fhir/administrative-gender"
                  }
                ],
                "type": "concept"
              }
            }
          ]
        ]
      }'
```

### FLARE - Check execute (manual)

To check if the execution is correct you can use the Flare execution endpoint /execute, which will execute the feasibility query on your FHIR server:

```
curl --location --request POST 'http://localhost:8084/query/execute' \
--header 'Content-Type: application/sq+json' \
--data-raw '<your-CCDL-here>'
```

Input for your CCDL is identical to the input for the translation endpoint above.

> **Note**: You can create a feasibility query in the UI <https://feasibility.forschen-fuer-gesundheit.de/> and use the Download function under "save > > query" to download a current CCDL to test.

The return value should be a number >= 0


## DSF

The DSF installation is described elsewhere. This troubleshooting focusses on troubleshooting the DSF Feasibility plugin.

### Feasibility Plugin

You can get the newest CQL and CCDL query recieved via your DSF, by using the `get-last-queries-from-dsf.sh` of this repository.


## Manual Connection test

To test whether your site returns answers to a feasibility query you can log into the central UI <https://feasibility.forschen-fuer-gesundheit.de/>
and upload your own test SQ under "My queries" (Meine Abfragen). To test whether you are generally connected you can use the `patient-query.json` in this folder. Should you not have an account please contact info@forschen-fuer-gesundheit.de.

Once you have loaded and sent the query you should check the logs of your Middleware to see if the query is shown in the respective logs.

## DQA

It is recommended for every DIC to use the DQA tool provided here <https://github.com/medizininformatik-initiative/fdpg-query-data-validation/> to analyse the FHIR resources loaded in the FHIR server.

Additionally the DIC can use the FLARE tool provided to see if the resources are found correctly:

### FLARE - DQA

FLARE can also be used to check if you have correctly implemented the FHIR resources so that they can be queried using our tools.
To check this, execute the following:

```bash
export FEASIBILITY_TEST_PRINT_SQ=false
export FEASIBILITY_TEST_CHECK_TRANSLATION=true
export FEASIBILITY_TEST_CHECK_EXECUTION=false
bash test-flare.sh
```

This will print the FHIR Search translation for our standard test scripts, which you can use to debug the FHIR resources on your server.
For example, the Observation query for hemoglobin would return:
`[base]/Observation?code=http://loinc.org|718-7&value-quantity=gt0|http://unitsofmeasure.org|g/dL`

which you can then execute against your FHIR server to see what it returns. If you cannot find any of the values try removing parts of the query, so that you can see 
if you have any resources for the code, here: 
`[base]/Observation?code=718-7`
Open the resource and then queck if your units are correct and you are using the right system.
If you cannot find any resources even with the code check whether this is correct and investigate further.


## Common problems and how to solve them

PROBLEM: Requests time out

DESCRIPTION: Some requests can time out depending on the used components and the hardware the site supplies.

SOLUTION: If this problem persists contact <info@forschen-fuer-gesundheit.de> to setup an appointment with one of our developers.
Please also see the tuning guide for the blaze server.
We do currently not recommend the HAPI FHIR server as it is not fast enough for larger datasets.

---
