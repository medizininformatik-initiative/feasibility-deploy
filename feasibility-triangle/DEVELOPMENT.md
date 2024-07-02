# Instructions for Development

The portal and triangle can be run locally for testing purposes.

Follow the instructions provided in the [README](./README.md#setting-up-the-feasibility-triangle) and insert the
following instructions between step 4 and step 5:

### Step 4.5 - Generate Self-Signed Certificates
In order to generate self-signed certificates which will be used for TLS encryption and client authentication execute
the following command:

```sh
./generate_cert.sh
```

You will be asked to provide one or more domains for your certificate. These domains must be accessible from inside
docker containers running on same host where the triangle will be started. The scripts defaults to the hostname of the
machine it is executed on. You can check the accessibility of the hostname by executing:

```sh
docker run --rm alpine:3 nslookup $(hostname)
```

If you don't have a hostname/domain which can be resolved from inside a docker container, you can use `localhost` if
you are running the triangle (and portal) on the same machine you want to access the frontends via browser or use
custom hostnames in your `hosts` file (`/etc/hosts` for Linux/Mac, `C:\Windows\system32\drivers\etc\hosts` for Windows)
for the localhost ip `127.0.0.1`. In this case it is necessary to use the
[subdomains.nginx.conf](./rev-proxy/subdomains.nginx.conf) as nginx configuration (see`rev-proxy/.env`) and preferrably
use the subdomains `fhir.localhost`, `auth.localhost` and`flare.localhost`. The subdomain for keycloak (`auth.localhost`
in this case) needs to be forwarded to the host for the fhir-server, fhir-server-frontend and flare docker container.
This is already preconfigured in the `docker-compose.yml` files for these services (see section `extra-hosts` in
[fhir-server/docker-compose.yml](./fhir-server/docker-compose.yml) and
[flare/docker-compose.yml](./flare/docker-compose.yml)).
