#

## Troubleshooting AKTIN Connection

To check if the aktin client is running use the command `docker logs -f abide-deploy_aktin-client_1`

If it is running correctly it will display:
```
INFO: websocket connection established
Mar 21, 2022 1:30:44 PM org.aktin.broker.client.live.sysproc.ProcessExecutionService run
INFO: websocket ping-pong delay set to 60s
```

If the container is not running follow these steps:

Check if the aktin broker is currently available from your host: `curl https://aktin.forschen-fuer-gesundheit.de/broker/status`

If the aktin client does not start up, add the following to the docker-compose.yml of the atkin client: 
`entrypoint: sh -c "tail -f /dev/null"` and restart the container using `bash stop-node.sh`and `bash start-node.sh`

Check if you can connect to the broker from within your docker container:

`docker exec abide-deploy_aktin-client_1 sh -c "curl https://aktin.forschen-fuer-gesundheit.de/broker/status"`

If you cannot connect to this endpoint, please check your proxy configurations.

Other common errors invole the environment variables set. To check if they are correct:

log in to the aktin container `docker exec -it abide-deploy_aktin-client_1 sh` and then execute `echo $<your-variable-name-here>`.
Note that you can find the name of your variable in the docker-compose.yml under environment. 
If your variable is not set double check your .env file and if the env var is set and still not correct in the container directly 
replace it in the docker-compose file, for example change,
from:
`BROKER_ENDPOINT_URI: ${CODEX_FEASIBILITY_AKTIN_CLIENT_BROKER_ENDPOINT_URI:-http://aktin-broker:8080/broker/}`
to:
`BROKER_ENDPOINT_URI: <my-variable-value-here`

Remove or Comment-Out the `entrypoint: sh -c "tail -f /dev/null"` from your docker-compose.yml and restart the containers, using `bash stop-node.sh`and `bash start-node.sh`.


## Check if FLARE is running

To see if flare is running use `docker ps` to list all your containers currently running.
There should be one container called: abide-deploy_node-flare_1

If it is running your can see its logs by using: `docker logs -f abide-deploy_node-flare_1`


## run the test script (automatic check for FLARE FHIR Search translation and execution)

To see if queries are correctly translated and whether you get results for common resources, run the `feasibility-test.sh` in this repository.

## check if translation is correct (manual)

To check if the translation is correct and you have updated to the correct ontology mapping files,
you can access the flare component directly:

Flare has a translation endpoint /translate, which allows you to get the fhir search representation of a request:

```
curl --location --request POST 'http://localhost:8084/query/translate' \
--header 'Content-Type: application/sq+json' \
--data-raw '<your-structured-query-here>'
```

You can extract a structured query from the `aktin-requests.log` once a request has been recieved by your system and send it to your local flare.

this will give you an output, which contains the fhir search translation for each criterion in our Structured-Query, for example:

The Structured-Query:
```
curl --location --request POST 'http://localhost:8084/query/execute' \
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
        "valueFilter": {
          "selectedConcepts": [
            {
              "code": "female",
              "system": "http://hl7.org/fhir/administrative-gender",
              "display": "Female"
            }
          ],
          "type": "concept"
        }
      }
    ]
  ]
}'
```

should give you an output similar to:

```
{"name":"intersection","operands":[{"name":"union","operands":["[base]/Patient?gender=female"]}]}
```

The FHIR search string can then be used with your FHIR Server directly, to recieve the response from the server.
To use it the base url of the fhir server has to be replaced according to how you call the server from your system.
In our example:
Change `http://fhir-server:8080/fhir/Patient?gender=female` to `<my-fhir-server-base-url>/Patient?gender=female`

## Check if execution is correct and returns the expected results (manual)


To check if the execution is correct you can use the Flare execution endpoint /execute, which will execute the feasibility query on your FHIR server:

```
curl --location --request POST 'http://localhost:8084/query/execute' \
--header 'Content-Type: application/sq+json' \
--data-raw '<your-structured-query-here>'
```

Input for your structured query is identical to the input for the translation endpoint above.

The return value should be a number >= 0

