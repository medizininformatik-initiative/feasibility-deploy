# The Feasibility Triangle


The Feasibility Triangle part of this Repository provides a site (data integration center) with all the neccessary components to set up in order to allow feasibiliy queries from the central feasibility portal.


## Overview

The Feasibility Triangle is composed of four components:

1. A Middleware Client (AKTIN or DSF)
2. A Feasibility Analysis Request Executor (FLARE)
3. A FHIR Server (Blaze)
4. Reverse Proxy (NGINX)

The reverse proxy allows for integration into a site's multi-server infrastructure. It also provides basic auth capability for FHIR server and FLARE components.

### CQL Support

[CQL](https://cql.hl7.org) is supported. If your FHIR server **does not** support CQL itself then the FLARE component must be used as a kind of translation mediator.

### Component Interchangeability

All components work with well-defined interfaces making them interchangeable. Thus, there are different middleware clients and FHIR servers to chose from.

This leads to the following setup options:

- AKTIN - FLARE (FHIR Search) - FHIR Server (not CQL ready)
- AKTIN - FHIR Server (CQL ready)
- DSF - FLARE (FHIR Search) - FHIR Server (not CQL ready)
- DSF - FHIR Server (CQL ready)

**_When choosing a FHIR server, make sure it supports either CQL or the required FHIR search capabilities._**

## Setting up the Feasibility Triangle

### Step 1 - Installation Docker

The installation of the Feasibility Triangle requires Docker (https://docs.docker.com/engine/install/ubuntu/) and docker-compose (https://docs.docker.com/compose/install/).
If not already installed on your VM, install using the links provided above.

### Step 2 - clone this Repository to your virtual machine

ssh to your virtual machine and switch to sudo `sudo -s`.
Designate a folder for your setup in which to clone the deploy repository, we suggest /opt (`cd /opt`)
Navigate to the directory and clone this repository: `git clone https://github.com/medizininformatik-initiative/feasibility-deploy.git`
Navigate to the feasibility-triangle folder of the repository: `cd /opt/feasibility-deploy/feasibility-triangle`
Checkout the version (git tag) of the feasibility triangle you would like to install: `git checkout tags/<your-tag-name-here>`

### Step 3 - Initialise .env files

The feasibility portal requires .env files for the docker-compose setup. If you are setting up the project new and have not done so yet execute the `initialise-triangle-env-files.sh`.

If you have set up the portal before compare the .env to the .env.default env files of each component and copy the additional params as appropriate

### Step 4 - Set Up basic auth

To set up basic auth you can execute the `setup-base-auth.sh <username> <password>` to add a simple .htpasswd to protect your FHIR Server and FLARE component with basic authentication.
This creates a .htpasswd file in the `auth` directory, which will be mounted to the nginx, which is part of this deployment repository.

### Step 5 - Set Up ssl certificates

Running this setup safely at your site, requires a valid certificate and domain. Please contact the responsible body of your institution to recieve both a domain and certificate.
You will require two .pem files: a cert.pem (certificate) and key.pem (private key).

Once you have the appropriate certificates you should save them under `/opt/feasibility-deploy/feasibility-triangle/auth`.
Set the rights for all files of the auth folder to 655 `chmod 655 /opt/feasibility-deploy/feasibility-triangle/auth/*`.  

- If you do not provide a cert.pem and key.pem file the reverse proxy will not start up, as it will not be able to provide a secure https connection.
- The rest of the feasibility triangle will still work, as it does create a connection to the outside without the need to make itself accessible. 
- However, if you would for example load data into the FHIR server from an ETL job on another VM you will need to expose the FHIR server via a reverse proxy, which will require the certificates above.

### Step 6 - Load the ontology mapping files

If used, (see "Overview") The FLARE component requires a mapping file and ontology tree file to translate an incoming feasibility query into FHIR Search queries.
Both can be downloaded here: https://confluence.imi.med.fau.de/display/ABIDEMI/Ontologie

Upload the  mapping_*.zip file to your server, unpack it and copy the ontology files to your triangle ontology folder

```bash
sudo -s
mkdir /<path>/<to>/<folder>/<of>/<choice>
cd /<path>/<to>/<folder>/<of>/<choice>
unzip mapping_*.zip
cd mapping
cp * /opt/feasibility-deploy/feasibility-triangle/ontology
```

### Step 7 - Configure your feasibility triangle

If you use the default triangle setup you only have to configure the AKTIN client to connect to the central feasibility portal as the rest of the setup will already be correctly configured for you.

Follow the [DSF configuration wiki](https://github.com/medizininformatik-initiative/feasibility-deploy/wiki/DSF-Middleware-Setup) if you want to use the DSF middleware instead.

To configure the AKTIN client in the default setup, change the following environment variables in the file `/opt/feasibility-deploy/feasibility-triangle/aktin-client/.env` according to the paragraph **Configurable environment variables** of this README:

- FEASIBILITY_AKTIN_CLIENT_BROKER_ENDPOINT_URI
- FEASIBILITY_AKTIN_CLIENT_AUTH_PARAM
- FEASIBILITY_AKTIN_CLIENT_WEBSOCKET_PING_SECONDS
- FEASIBILITY_AKTIN_PROCESS_EXECUTOR_THREADS

If you are using AKTIN, the new version of the AKTIN client logs to the STDOUT of the container. You will be responsible for persisting these container logs beyond the stopping and starting of the container.

### Step 8 - Start the feasibility triangle

To start the triangle navigate to `/opt/feasibility-deploy/feasibility-triangle` and
execute `bash start-triangle.sh`.

This starts the following default triangle: 
AKTIN (Middleware) - FLARE (FHIR Search executor) - BLAZE (FHIR Server)

- AKTIN: Used to connect to the central platform and allow queries from the Zars
- FLARE: A Rest Service, which is needed to translate, execute and evaluate a feasibility query on a FHIR Server using FHIR Search
- BLAZE: The FHIR Server which holds the patient data for feasibility queries


If you would like to pick other component combinations you can start each component individually by setting your compose project (`export FEASIBILITY_COMPOSE_PROJECT=feasibility-deploy`)
navigating to the respective components folder and executing: 
`docker-compose -p $FEASIBILITY_COMPOSE_PROJECT up -d`


### Step 9 - Access the Triangle

In the default coniguration and given that you have set up a ssl certifcate in step 4 the setup will expose the following services:

These are the URLs for access to the webclients via nginx:

| Component   | URL                              | User             | Password         |
|-------------|----------------------------------|------------------|------------------|
| Flare       | <https://your-domain/flare>      | chosen in step 3 | chosen in step 3 |
| FHIR Server | <https://your-domain/fhir>       | chosen in step 3 | chosen in step 3 |

Accessible service via localhost:

| Component   | URL                              | User             | Password         |
|-------------|----------------------------------|------------------|------------------|
| Flare       | <http://localhost:8084>          | None required    | None required    |
| FHIR Server | <http://localhost:8081>          | None required    | None required    |

Please be aware, that if you would like to access the services on localhost without a password you will need to set up an ssh tunnel to your server and forward the respective ports.

For example for the FHIR Server: ssh -L 8081:127.0.0.1:8081 your-username@your-server-ip

### Step 10 - Init Testdata (Optional)

To initialise testdata execute the `get-mii-testdata.sh`. This will download MII core dataset conformant testdata from <https://github.com/medizininformatik-initiative/kerndatensatz-testdaten>
unpack it and save them to the testdata folder of this repository.

You can then load the data into your FHIR Server using the `upload-testdata.sh` script.

### Configurable environment variables

| Env Variable                                                          | Description                                                                                                                                                                  | Default                                            | Possible Values                                    | Component |
|-----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|----------------------------------------------------|-----------|
| FEASIBILITY_AKTIN_CLIENT_BROKER_REQUEST_MEDIATYPE                     | The media type of the query you would like to handle                                                                                                                         | application/sq+json                                | application/sq+json, text/cql                      | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_BROKER_RESULT_MEDIATYPE                      | The media type of the query response you return                                                                                                                              | application/json                                   | application/json                                   | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_BROKER_ENDPOINT_URI                          | The URL of the AKTIN broker endpoint                                                                                                                                         | http://aktin-broker:8080/broker/                   | URL                                                | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_AUTH_CLASS                                   | Type of authentication used by AKTIN                                                                                                                                         | org.aktin.broker.client2.auth.ApiKeyAuthentication | org.aktin.broker.client2.auth.ApiKeyAuthentication | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_AUTH_PARAM                                   | The API key of your site                                                                                                                                                     | xxxApiKey123                                       | API key token                                      | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_WEBSOCKET_DISABLED                       | enables or disables the websocket - if websocket is disabled the client will poll requests instead - the polling interval is then configured using the env var FEASIBILITY_AKTIN_CLIENT_WEBSOCKET_RECONNECT_SECONDS                                                                  | false                                                 | boolean                                   | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_WEBSOCKET_PING_SECONDS                       | The time in which your AKTIN client pings the AKTIN broker to ensure idle websocket conections stay open                                                                     | 60                                                 | Integer (seconds)                                  | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_WEBSOCKET_RECONNECT_SECONDS                  || 10                                                                                                                                                                           | Integer (seconds)                                  | AKTIN                                              |
| FEASIBILITY_AKTIN_CLIENT_WEBSOCKET_RECONNECT_POLLING                  || TRUE                                                                                                                                                                         || AKTIN                                              |
| FEASIBILITY_AKTIN_CLIENT_PROCESS_TIMEOUT_SECONDS                      | The timeout within which a process has to return before the client sends a "failed" message to the AKTIN broker                                                              | 60                                                 | Integer (seconds)                                  | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_PROCESS_COMMAND                              | The command to be executed on recieving a feasibility query. Allows one to switch between flare and cql execution                                                            | /opt/aktin/call-flare.sh                           | /opt/aktin/call-flare.sh, /opt/aktin/call-cql.sh   | AKTIN     |
| FEASIBILITY_AKTIN_CLIENT_PROCESS_ARGS                                 || 10                                                                                                                                                                           | Integer (seconds)                                  | AKTIN                                              |
| FEASIBILITY_AKTIN_PROCESS_EXECUTOR_THREADS                                 |configures how many parallel threads AKTIN will use to process requests simultaniously| 2 | Integer (number of threads)                                  | AKTIN                                              |
| FEASIBILITY_AKTIN_FLARE_URL                               | the URL of the FLARE component if used                                                                                                                                       | http://flare:8080/query/execute                                  | URL                                                | AKTIN     |
| FEASIBILITY_AKTIN_FLARE_USER                               | the basic auth user for flare if needed                                                                                                                                       |                                   |                                                 | AKTIN     |
| FEASIBILITY_AKTIN_FLARE_PW                               | the basic auth password for flare if needed                                                                                                                                       |                                  |                                                 | AKTIN     |
| FEASIBILITY_AKTIN_LOG_LEVEL                               | the general log level for the AKTIN client                                                                                                                                       |    INFO                        | ALL, FINEST, FINER, FINE, CONFIG, INFO, SEVERE, OFF                                                | AKTIN     |
| FEASIBILITY_AKTIN_LOG_LEVEL_FEASIBILITY                               | the log level of the feasibility plugin for the AKTIN client - note that on FINE above all incoming queries are logged - on FINEST and above it also logs the obfuscated result to each query                                                                                                                                       | FINE            | ALL, FINEST, FINER, FINE, CONFIG, INFO, SEVERE, OFF                                                | AKTIN     |
| FEASIBILITY_AKTIN_JAVA_OPTS                                           | Provides Java options to the AKTIN client - can be used to configure proxy use. For example : " Dhttps.proxyHost=squid -Dhttps.proxyPort=3128"                               || valid java options                                 | AKTIN                                              |
| FEASIBILITY_AKTIN_CQL_FHIR_USER                               | basic auth user to connect to FHIR server if CQL is used                                                                                                                     ||| AKTIN                                              |
| FEASIBILITY_AKTIN_CQL_FHIR_PW                                 | basic auth password to connect to FHIR server if CQL is used                                                                                                                 ||| AKTIN                                              |
| FEASIBILITY_AKTIN_CQL_FHIR_BASE_URL                                       | FHIR server base url the AKTIN client is to use to connect to the FHIR server                                                                                                | http://fhir-server:8080/fhir                       || AKTIN                                              |
| FEASIBILITY_AKTIN_HARD_RATE_LIMIT_NREQUESTS                                       | Hard Rate limit - if this is breached the application will reject all future requests until it is restarted                                                                                               | 300                       | integer| AKTIN                                              |
| FEASIBILITY_AKTIN_HARD_RATE_LIMIT_RESET_MINUTES                                       | Time after which the rate limit configured in FEASIBILITY_AKTIN_HARD_RATE_LIMIT_NREQUESTS is reset                                                                                               | 60                       |integer| AKTIN                                              |
| FEASIBILITY_AKTIN_OBFUSCATOR_EPSILON                                       | Epsilon used in the Result obfuscator to obfuscate the results using a Laplace function                                                                                                | 0.28                       |double| AKTIN                                              |
| FHIR_SERVER_BASE_URL                                                  | The base URL of the FHIR server the fhir server uses to generate next links                                                                                                  | http://fhir-server:8080                            || BLAZE                                              |
| FHIR_SERVER_LOG_LEVEL                                                 | log level of the FHIR server                                                                                                                                                 | debug                                              | debug, info, error                                 | BLAZE     |
| BLAZE_JVM_ARGS                                                        | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                                    | -Xmx4g                                             || BLAZE                                              |
| BLAZE_BLOCK_CACHE_SIZE                                                | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                                    | 256                                                || BLAZE                                              |
| BLAZE_DB_RESOURCE_CACHE_SIZE                                          | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                                    | 2000000                                            || BLAZE                                              |
| BLAZE_DB_RESOURCE_HANDLE_CACHE_SIZE                                   | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                                    | 100000                                             || BLAZE                                              |
| PORT_FHIR_SERVER_LOCALHOST                                            | The exposed docker port of the FHIR server                                                                                                                                   | 127.0.0.1:8081                                     | should always include 127.0.0.1                    | BLAZE     |
| FEASIBILITY_FLARE_PORT                                                | The exposed docker port of the FLARE componenet                                                                                                                              | 127.0.0.1:8084                                     | should always include 127.0.0.1                    | FLARE     |
| FLARE_FHIR_SERVER_URL                                                 | The Url of the FHIR server FLARE uses to connect to the FHIR server                                                                                                          | http://fhir-server:8080/fhir/                      | URL                                                | FLARE     |
| FLARE_FHIR_USER                                                       | basic auth user to connect to FHIR server                                                                                                                                    ||| FLARE                                              |
| FLARE_FHIR_PW                                                         | basic auth password to connect to FHIR server if CQL is used                                                                                                                 ||| FLARE                                              |
| FLARE_FHIR_PAGE_COUNT                                                 | The number of resources per page FLARE asks for from the FHIR server                                                                                                         | 500                                                || FLARE                                              |
| FLARE_EXEC_CORE_POOL_SIZE                                             | The core thread pool size                                                                                                                                                    | 4                                                  | Integer                                            | FLARE     |
| FLARE_EXEC_MAX_POOL_SIZE                                              | The max thread pool size                                                                                                                                                     | 16                                                 | Integer                                            | FLARE     |
| FLARE_EXEC_KEEP_ALIVE_TIME_SECONDS                                    | The time threads are kept alive                                                                                                                                              | 10                                                 | Integer                                            | FLARE     |
| FLARE_LOG_LEVEL                                                       | log level of flare                                                                                                                                                           | debug                                              | off, fatal, error, warn, info, debug, trace        | FLARE     |
| FEASIBILITY_TRIANGLE_REV_PROXY_PORT                                   | The exposed docker port of the reverse proxy - set to 443 if you want to use standard https and you only have the feasibility triangle installed on your server              | 444                                                | Integer (valid port)                               | REV Proxy |
| FEASIBILITY_DSF_CLIENT_PROCESS_FORWARD_PROXY_HOST                     | Forward proxy host.                                                                                                                                                          |                                                    | FQDN                                               | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FORWARD_PROXY_PORT                     | Forward proxy port.                                                                                                                                                          |                                                    | Integer                                            | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FORWARD_PROXY_USERNAME                 | Username for a forward proxy if it requires one.                                                                                                                             |                                                    | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FORWARD_PROXY_PASSWORD                 | Password for a forward proxy if it requires one.                                                                                                                             |                                                    | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FHIR_SERVER_BEARER_AUTH_TOKEN          | Bearer token used for authentication against a client target. Do not prefix this with `Bearer `!                                                                             |                                                    | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FHIR_SERVER_BASIC_AUTH_USERNAME        | Username for basic authentication against a FHIR server client target.                                                                                                       |                                                    | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FHIR_SERVER_BASIC_AUTH_PASSWORD        | Password for basic authentication against a FHIR server client target.                                                                                                       |                                                    | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FHIR_SERVER_CONNECTION_TIMEOUT         | Timeout for establishing a connection to a FHIR server client target in `ms`.                                                                                                | 2000                                               | Integer                                            | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FHIR_SERVER_CONNECTION_REQUEST_TIMEOUT | Timeout for requesting a connection to a FHIR server client target in `ms`.                                                                                                  | 20000                                              | Integer                                            | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FHIR_SERVER_NETWORK_OPS_TIMEOUT        | Timeout for blocking a read / write network operation to a FHIR server without failing in `ms`.                                                                              | 20000                                              | Integer                                            | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_TRUST_STORE_PATH                       | Path to a trust store used for connecting to a FHIR server. Necessary when using self-signed certificates.                                                                   | /opt/bpe/truststore.p12                            | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_TRUST_STORE_PASSWORD                   | Password for opening the trust store used for connecting to a FHIR server.                                                                                                   |                                                    | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_KEY_STORE_PATH                         | Path to a key store used for authenticating against a FHIR server or proxy using a client certificate.                                                                       | /opt/bpe/keystore                                  | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_KEY_STORE_PASSWORD                     | Password for opening the key store used for authenticating against a FHIR server or proxy.                                                                                   |                                                    | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FHIR_SERVER_BASE_URL                   | Base URL to a FHIR server or proxy for feasibility evaluation. This can also be the base URL of a reverse proxy if used. Only required if evaluation strategy is set to cql. |                                                    | URL                                                | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_EVALUATION_STRATEGY                    | Defines whether the feasibility shall be evaluated using cql or structured-query. Using the latter requires a FLARE instance.                                                |                                                    | `structured-query`, `cql`                          | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_EVALUATION_OBFUSCATE                   | Defines whether the feasibility evaluation result shall be obfuscated.                                                                                                       |                                                    | Boolean                                            | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_ORGANIZATION_IDENTIFIER                | Identifier of this organization.                                                                                                                                             | Test_DIC_1                                         | String                                             | DSF       |
| FEASIBILITY_DSF_CLIENT_PROCESS_FLARE_WEBSERVICE_BASE_URL              | Base URL to a FLARE instance. Only required if evaluation strategy is set to structured-query.                                                                               | http://node-flare:5000/                            | URL                                                | DSF       |



## Updating the Feasibility Triangle

If you have already installed the feasibility triangle and just want to update it, follow these steps:


### Step 1 - Stop your triangle

`cd /opt/feasibility-deploy/feasibility-triangle && bash stop-triangle.sh`

### Step 2 - Update repository and check out new tag

`cd /opt/feasibility-deploy/feasibility-triangle && git pull`
`git checkout <new-tag>`

### Step 3 - transfer the new env variables

Compare the .env and .env.default files for each component and add any new variables from the .env.default file to the .env file.
Keep the existing configuration as is.

### Step 4 - Update your ontology

If used, (see "Overview") The FLARE component requires a mapping file and ontology tree file to translate an incoming feasibility query into FHIR Search queries.
Both can be downloaded here: https://confluence.imi.med.fau.de/display/ABIDEMI/Ontologie.

Make sure that you use the newest version.

Upload the  mapping_*.zip file to your server, unpack it and copy the ontology files to your triangle ontology folder.

```bash
sudo -s
mkdir /<path>/<to>/<folder>/<of>/<choice>
cd /<path>/<to>/<folder>/<of>/<choice>
unzip mapping_*.zip
cd mapping
cp * /opt/feasibility-deploy/feasibility-triangle/ontology
```

Existing mapping files should be replaced.

### Step 5 - Start your triangle

To start the triangle navigate to `/opt/feasibility-deploy/feasibility-triangle` and
execute `bash start-triangle.sh`.

### Step 6 - Update your DSF

If you are using the DSF to connect to the central feasibility portal, plese follow the instructions here:
https://github.com/medizininformatik-initiative/feasibility-deploy/wiki/DSF-Middleware-Setup

### Step 7 - Log in to the central feasibility portal and test your connection

Ask for the Url of the central portal at the FDPG or check Confluence for the correct address.

Log in to the portal and send a request with the Inclusion Criterion chosen from the Inclusion criteria tree (folder sign under Inclusion Criteria) 
"Person > PatientIn > Geschlecht: Female,Male"

and press "send".

Check your triangle aktin client logs:
`cat /opt/feasibility-deploy/feasibility-triangle/aktin-client/aktin-requests.log`

you should see output similar to:
```
##### INCOMING REQUEST at Thu Sep  8 11:49:08 UTC 2022 #####
----BEGIN REQUEST----
{"version":"http://to_be_decided.com/draft-1/schema#","inclusionCriteria":[[{"termCodes":[{"code":"gender","system":"mii.abide","display":"Geschlecht"}],"attributeFilters":[{"type":"concept","selectedConcepts":[{"code":"female","system":"http://hl7.org/fhir/administrative-gender","display":"Female"},{"code":"male","system":"http://hl7.org/fhir/administrative-gender","display":"Male"}],"attributeCode":{"code":"gender","system":"mii.abide","display":"Geschlecht"}}]}]]}
----END REQUEST----
----BEGIN RESPONSE----
65
----END RESPONSE----
```









