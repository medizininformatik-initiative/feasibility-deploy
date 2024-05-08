# The Feasibility Triangle


The Feasibility Triangle part of this repository provides a site (data integration center) with all the necessary components to set up in order to allow feasibility queries from the central feasibility portal.


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

- DSF - FLARE (FHIR Search) - FHIR Server (not CQL ready)
- DSF - FHIR Server (CQL ready)

**_When choosing a FHIR server, make sure it supports either CQL or the required FHIR search capabilities._**

## Setting up the Feasibility Triangle

### Step 1 - Installation Docker

The installation of the Feasibility Triangle requires Docker (https://docs.docker.com/engine/install/ubuntu/) and docker-compose (https://docs.docker.com/compose/install/).
If not already installed on your VM, install using the links provided above.

### Step 2 - Clone this Repository to your virtual machine

ssh to your virtual machine and switch to sudo `sudo -s`.
Designate a folder for your setup in which to clone the deploy repository, we suggest /opt (`cd /opt`)
Navigate to the directory and clone this repository: `git clone https://github.com/medizininformatik-initiative/feasibility-deploy.git`
Navigate to the feasibility-triangle folder of the repository: `cd /opt/feasibility-deploy/feasibility-triangle`
Checkout the version (git tag) of the feasibility triangle you would like to install: `git checkout <your-tag-name-here>`

### Step 3 - Initialise .env files

The feasibility portal requires .env files for the docker-compose setup. If you are performing a new setup of the project, execute the `initialise-triangle-env-files.sh`.

If you have set up the portal before compare the `.env` to the `.env.default` env files of each component and copy the additional params as appropriate.

### Step 4 - Set Up basic auth

To set up basic auth you can execute the `setup-base-auth.sh <username> <password>` to add a simple .htpasswd to protect your FHIR Server and FLARE component with basic authentication.
This creates a .htpasswd file in the `auth` directory, which will be mounted to the nginx, which is part of this deployment repository.

### Step 5 - Set Up ssl certificates

Running this setup safely at your site requires a valid certificate and domain. Please contact the responsible body of your institution to receive both a domain and certificate.
You will require two .pem files: a cert.pem (certificate) and key.pem (private key).

Once you have the appropriate certificates you should save them under `/opt/feasibility-deploy/feasibility-triangle/auth`.
Set the rights for all files of the auth folder to 655 `chmod 655 /opt/feasibility-deploy/feasibility-triangle/auth/*`.

- If you do not provide a cert.pem and key.pem file the reverse proxy will not start up, as it will not be able to provide a secure https connection.
- The rest of the feasibility triangle will still work, as it does create a connection to the outside without the need to make itself accessible.
- However, if you would for example load data into the FHIR server from an ETL job on another VM you will need to expose the FHIR server via a reverse proxy, which will require the certificates above.

### Step 6 - Load the ontology mapping files

**Note:** The ontology is now part of the FLARE image and will not have to be loaded manually.

### Step 7 - Configure your feasibility triangle

If you use the default triangle setup you only have to configure the DSF middleware to connect to the central feasibility portal. Follow the [DSF configuration wiki][1].

Please note that all user env variables should be changed and all password variables should be set to secure passwords.


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
DSF (Middleware) - FLARE (FHIR Search executor) - BLAZE (FHIR Server)

- DSF: Used to connect to the central platform and allow queries from the FDPG
- FLARE: A Rest Service, which is needed to translate, execute and evaluate a feasibility query on a FHIR Server using FHIR Search
- BLAZE: The FHIR Server which holds the patient data for feasibility queries


If you would like to pick other component combinations you can start each component individually by setting your compose project (`export FEASIBILITY_COMPOSE_PROJECT=feasibility-deploy`)
navigating to the respective components folder and executing:
`docker-compose -p $FEASIBILITY_COMPOSE_PROJECT up -d`


### Step 9 - Access the Triangle

In the default configuration, and given that you have set up a SSL certificate in step 4, the setup will expose the following services:

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

Please be aware that you will need to set up an ssh tunnel to your server and forward the respective ports if you would like to access the services on localhost without a password.

For example for the FHIR Server: ssh -L 8081:127.0.0.1:8081 your-username@your-server-ip


### Step 10 - Update your Blaze Search indices

If you are using the Blaze server provided in this repository check if new items have been added to the fhir-server/custom-search-parameters.json since your last update.
If new search parameters have been added follow the "fhir-server/README.md -> Re-indexing for new custom search parameters" section to update your FHIR server indices.

### Step 11 - Init Testdata (Optional)

To initialise testdata execute `get-mii-testdata.sh`. This will download MII core dataset compliant testdata from <https://github.com/medizininformatik-initiative/kerndatensatz-testdaten>,
unpack it and save it to the testdata folder of this repository.

You can then load the data into your FHIR Server using the `upload-testdata.sh` script.

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

**Note:** The ontology is now part of the FLARE image and will not have to be loaded manually.

### Step 5 - Start your triangle

To start the triangle navigate to `/opt/feasibility-deploy/feasibility-triangle` and
execute `bash start-triangle.sh`.

### Step 6 - Update your DSF

If you are using the DSF to connect to the central feasibility portal, please follow the instructions in the [DSF configuration wiki][1].

### Step 7 - Log in to the central feasibility portal and test your connection

Ask for the Url of the central portal at the FDPG or check Confluence for the correct address.

Log in to the portal and send a request with the Inclusion Criterion chosen from the Inclusion criteria tree (folder sign under Inclusion Criteria)
"Person > PatientIn > Geschlecht: Female,Male"

and press "send".

Check your triangle DSF BPE App logs:
docker logs -f id-of-the-dsf-bpe-app-container

you should see output similar to:
```
Mar 29, 2023 12:59:57 PM feasibility.FeasibilityExecution doExecution
FINE: {"version":"http://to_be_decided.com/draft-1/schema#","display":"","inclusionCriteria":[[{"termCodes":[{"code":"263495000","system":"http://snomed.info/sct","display":"Geschlecht"}],"context":{"code":"Patient","system":"fdpg.mii.cds","version":"1.0.0","display":"Patient"},"valueFilter":{"selectedConcepts":[{"code":"female","display":"Female","system":"http://hl7.org/fhir/administrative-gender"},{"code":"male","display":"Male","system":"http://hl7.org/fhir/administrative-gender"}],"type":"concept"}}]]}
```

### Step 8 - Update your Blaze Search indices

If you are using the Blaze server provided in this repository check if new items have been added to the fhir-server/custom-search-parameters.json since your last update.
If new search parameters have been added follow the "fhir-server/README.md -> Re-indexing for new custom search parameters" section to update your FHIR server indices.

## Configuration

### Configurable environment variables

| Env Variable                        | Description                                                                                                                                                     | Default                       | Possible Values                             | Component |
|-------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|---------------------------------------------|-----------|
| FHIR_SERVER_BASE_URL                | The base URL of the FHIR server the fhir server uses to generate next links                                                                                     | http://fhir-server:8080       |                                             | BLAZE     |
| FHIR_SERVER_LOG_LEVEL               | log level of the FHIR server                                                                                                                                    | debug                         | debug, info, error                          | BLAZE     |
| BLAZE_JVM_ARGS                      | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | -Xmx4g                        |                                             | BLAZE     |
| BLAZE_BLOCK_CACHE_SIZE              | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | 256                           |                                             | BLAZE     |
| BLAZE_DB_RESOURCE_CACHE_SIZE        | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | 2000000                       |                                             | BLAZE     |
| BLAZE_DB_RESOURCE_HANDLE_CACHE_SIZE | see: https://github.com/samply/blaze/blob/master/docs/deployment/environment-variables.md                                                                       | 100000                        |                                             | BLAZE     |
| PORT_FHIR_SERVER_LOCALHOST          | The exposed docker port of the FHIR server                                                                                                                      | 127.0.0.1:8081                | should always include 127.0.0.1             | BLAZE     |
| FEASIBILITY_FLARE_PORT              | The exposed docker port of the FLARE componenet                                                                                                                 | 127.0.0.1:8084                | should always include 127.0.0.1             | FLARE     |
| FLARE_FHIR_SERVER_URL               | The Url of the FHIR server FLARE uses to connect to the FHIR server                                                                                             | http://fhir-server:8080/fhir/ | URL                                         | FLARE     |
| FLARE_FHIR_USER                     | basic auth user to connect to FHIR server                                                                                                                       |                               |                                             | FLARE     |
| FLARE_FHIR_PW                       | basic auth password to connect to FHIR server if CQL is used                                                                                                    |                               |                                             | FLARE     |
| FLARE_FHIR_PAGE_COUNT               | The number of resources per page FLARE asks for from the FHIR server                                                                                            | 500                           |                                             | FLARE     |
| FLARE_FHIR_MAX_CONNECTIONS          | maximum number of connections flare will open to fhir server simultaniously                                                                                     | 32                            |                                             | FLARE     |
| FLARE_CACHE_MEM_SIZE_MB             | in memory cache size in mb                                                                                                                                      | 1024                          |                                             | FLARE     |
| FLARE_CACHE_MEM_EXPIRE              | in memory cache time to expire                                                                                                                                  | PT48H                         | ISO 8601 time duration                      | FLARE     |
| FLARE_CACHE_MEM_REFRESH             | in memory chache time to refresh - not refresh should be shorter than expire                                                                                    | PT24H                         | ISO 8601 time duration                      | FLARE     |
| FLARE_CACHE_DISK_THREADS            | number of threads used to write to disk cache                                                                                                                   | 4                             | integer                                     | FLARE     |
| FLARE_CACHE_DISK_PATH               | disk path for disk cache inside docker container                                                                                                                | PT24H                         | string disk path                            | FLARE     |
| FLARE_CACHE_DISK_EXPIRE             | disk cache time to expire                                                                                                                                       | P7D                           | ISO 8601 time duration                      | FLARE     |
| FLARE_JAVA_TOOL_OPTIONS             | java tool options passed to the flare container                                                                                                                 | -Xmx4g                        |                                             | FLARE     |
| FLARE_LOG_LEVEL                     |                                                                                                                                                                 | info                          | off, fatal, error, warn, info, debug, trace | FLARE     |
| FEASIBILITY_TRIANGLE_REV_PROXY_PORT | The exposed docker port of the reverse proxy - set to 443 if you want to use standard https and you only have the feasibility triangle installed on your server | 444                           | Integer (valid port)                        | REV Proxy |


### Support for self-singed certificates

Depending on your setup you might need to use self-singed certificates and the tools will have to accept your CAs.
For the triangle self-singed certificates are currently supported for the PATH: BPE (DSF) -> FLARE -> FHIR SERVER.

#### BPE (DSF)

The DSF Feasibility Plugin supports self-signed certificates - please see [DSF configuration wiki][1]
for details.

#### FLARE

FLARE supports the use of self-signed certificates from your own CAs. On each startup FLARE will search through the folder /app/certs inside the container , add all found CA *.pem files to a java truststore and start FLARE with this truststore.

In order to add your own CA files, add your own CA *.pem files to the /app/certs folder of the container.

Using docker-compose mount a folder from your host (e.g.: ./certs) to the /app/certs folder, add your *.pem files (one for each CA you would like to support) to the folder and ensure that they have the .pem extension.


[1]: https://github.com/medizininformatik-initiative/feasibility-deploy/wiki/DSF-Middleware-Setup
