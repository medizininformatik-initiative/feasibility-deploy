# Running Test Queries
For running test queries against a running test deployment of the codex project the script `test/run_tests.sh` can be used for automatic test execution. In order to have predictable results the components NUM node and ZARS need to be started and ready, the NUM node needs to be initialized with test patient data and test cases needs to be cloned to a local directory containing specific search queries which all should result in the total number of patients of 1. These  queries are sent to the ZARS and the response is checked to contain a result of 1.

## Prerequisites
The following software needs to be installed to run the automatic test script:

* bash
* curl
* jq

For the [complete setup and test script execution](#complete-setup-and-test-script-execution) additional software is needed:

* docker
* docker-compose
* git
* python

## Set Environment
The following environment variables need to be set to run the automatic test script:

* `TEST_DATA_PATH`, path to the folder containing the cloned test cases project
* `QUERY_ENDPOINT_URL`, url of the query endpoint for sending search queries
* `AUTH_TOKEN_REQUEST_URL`, url of the access token provider endpoint
* `AUTH_USERNAME`, username of the user permitted to send queries
* `AUTH_PASSWORD`, password of the user permitted to send queries

## Complete Setup and Test Script Execution
You can use the following shell script to setup both the NUM node and the ZARS component with all test patient data as well as running the automatic test script. This assumes that all of the software listed in section [Prerequisites](#prerequisites) is installed and a write and read accessible directory `/tmp` exists:

```
export TEST_DATA_PATH=/tmp/codex-testdata
export QUERY_ENDPOINT_URL="http://localhost:8091/api/v1/query-handler/run-query"
export AUTH_TOKEN_REQUEST_URL="https://localhost:8443/auth/realms/codex-develop/protocol/openid-connect/token"
export AUTH_USERNAME=codex-developer
export AUTH_PASSWORD=codex
git clone --single-branch --branch main https://github.com/num-codex/codex-deploy.git /tmp/codex-deploy
git clone --single-branch --branch v0.2.0 https://github.com/num-codex/codex-testdata-to-sq.git $TEST_DATA_PATH
/tmp/codex-deploy/setup-all-base-auth.sh codex-developer $AUTH_PASSWORD
/tmp/codex-deploy/start-zars-and-num-node.sh --disable-result-obfuscation
(cd $TEST_DATA_PATH; python main.py)
until docker exec -it fhir-server curl -s --fail 'http://localhost:8080/health'; do
  sleep 1;
done
/tmp/codex-deploy/num-node/init-testdata.sh
/tmp/codex-deploy/test/run_tests.sh
```

The script starts the components with their default services. You can change the services to be used by editing the line

```
/tmp/codex-deploy/start-zars-and-num-node.sh --disable-result-obfuscation
```

and add the desired arguments. To find out about the available arguments and their values run the main startup script in the root directory of this git repository with the help flag (`-h`):

```
./start-zars-and-num-node.sh -h
```
