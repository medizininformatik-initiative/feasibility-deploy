# Docker Version of the AKTIN broker and client


## Broker Configuration

| EnvVar | Description | Example | Default |
|--------|-------------|---------|---------|
|AKTIN_BROKER_PORT| Host and port the aktin broker is exposed on externally (outside the docker container) | | 127.0.0.1:8080|
|PASSWORD| admin password for local admin http://localhost:8080/admin/html/login.html | |changeme|

The `api-key.properties` file can be used to add your own api keys for clients to allow them to connect to the broker.
When deploying your own version of the broker, please make sure to remove the example api keys and replace them with your own.

To add an api key for an admin client (a client which is allowed to submit requests to the broker) the api key needs to contain `OU=admin`, see example in this folder

## Client Configuration

The client has to be configured through the sysproc.properties file, which is mounted into the docker container.

| Sysproc var | Description | Example | Default |
|--------|-------------|---------|---------|
|broker.request.mediatype| | the mediatype the client expects from the broker (note the broker has stored multiple mediatypes for a request this will chose the mediatype to pick)|text |
|broker.result.mediatype | | the mediatype the client is sending back to the broker |application/json |
|broker.endpoint.uri | | |http://aktin-broker:8080/broker/ |
|client.auth.class | | | |
|client.auth.param | | | |
|client.websocket.reconnect.seconds | | | |
|client.websocket.reconnect.polling | | | |
|process.timeout.seconds | | | |
|process.command | |the path to the sh file which is to be executed by the client when the client recieves the request  |/opt/codex-aktin/return-request.sh|
|process.command.mapenv | | | |
|process.args | | | |

Note that the client passes the request to the chosen script file (process.command) on stdin.
The easiest way therefore to access the request from within your script is to use the following command `REQUEST_INPUT=$(cat)`

To use your own script file, mount it into the docker container (see example `docker-compose.broker.yml`)


## Run docker setup

To run the docker setup on one local machine execute the following commands:

```bash
export COMPOSE_PROJECT=codex-develop

cd aktin-broker
docker-compose -p $COMPOSE_PROJECT up -d
sleep 10
cd ../aktin-client
docker-compose -p $COMPOSE_PROJECT up -d
```

If you would like to deploy the broker and client individually copy the respective folder to the respective virtual machine
and execute `docker-compose -p $COMPOSE_PROJECT up -d`.


Once started visit the admin at:

http://localhost:8080/admin/html/login.html

user: admin
password: from AKTIN_ADMIN_PW environment variable - see above