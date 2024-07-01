# Additional Information for Blaze


## Adding custom Search Parameters and re-indexing Blaze

### New Search Parameter -> add to the custom-search-parameters.json

New Releases of MII FHIR profiles sometimes include new custom fhir search parameters, which have to be added to Blaze.
To add a new search parameter to Blaze it has to be added to the custom-search-parameters.json file in this repository.
We will always provide an FDPG compatible search parameter update
However if you have added your own search parameters to the file previously you will have to take this into account.

### Re-indexing for new custom search parameters

When adding a new custom search parameter Blaze needs to re-index.
Blaze currently only supports a full re-index, which has to be triggered manually by deleting the existing indices in the Blaze container and
restarting it.

Note: before re-indexing a current backup of the Blaze volume should be created:

To re-index Blaze proceed as follows:

1. Navigate to the fhir-server folder `cd fhir-server`
2. If you have enough disk space, just rename the index directory into index-old. If not, delete it **assuming you have a backup!**
- 2.1 either - Rename the index directory in the container `docker exec feasibility-deploy_fhir-server_1 mv /app/data/index /app/data/index-old`
- 2.2 or - Delete the index directory in the container `docker exec feasibility-deploy_fhir-server_1 rm -r /app/data/index`
3. Stop your Blaze `docker compose -p feasibility-deploy stop`
4. Start your Blaze `docker compose -p feasibility-deploy up -d`
5. Blaze will now rebuild all indices, which might take a while (up to 24 hours for larger datasets)
6. Blaze will be not accessible during re-indexing. Please plan for the downtime.

### Backup and restore docker volume

Below you will find a backup method for the volume of the Blaze server in this repository.
Please ensure that this works for your site (test it) and adjust the backup process accordingly.

*Backup*

```sh
docker run --rm -v feasibility-deploy_blaze-data:/volume -v /opt/feasibility-deploy/feasibility-triangle/fhir-server:/backup alpine tar -czf /backup/blaze-backup.tar.gzip -C /volume ./
```

*Restore*

```sh
docker run --rm -v feasibility-deploy_blaze-data:/volume -v /opt/feasibility-deploy/feasibility-triangle/fhir-server:/backup alpine sh -c 'rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xzf /backup/blaze-backup.tar.gzip'
```

### Testing your process - dry running it in a test environment

To get a better understanding of how Blaze, the backup and re-indexing process work we recommend going through the steps
below at least once to practice on a test server.

> [!NOTE]
> This assumes you already initialized, configured and started the triangle as described in [Setting up the Feasibility Triangle](../README.md#setting-up-the-feasibility-triangle).

1. Backup the custom-search-parameters.json `cp custom-search-parameters.json custom-search-parameters-backup.json`
2. Delete all entries in the `entry` array of the custom-search-parameters.json
3. (Re-)Start your fhir server: `docker compose stop && docker compose up -d`
4. Load the testdata `cd .. && bash get-mii-testdata.sh && bash upload-testdata.sh`
5. Get an access token of you OpenID Connect provider an save it in a variable called `ACCESS_TOKEN`. If you use the
bundled keycloak you can execute `export ACCESS_TOKEN="$(../get-fhir-server-access-token.sh)"`.
6. Once the server has started up execute the following curl request:

```sh
curl 'http://localhost:8081/fhir/Consent?mii-provision-provision-code=2.16.840.1.113883.3.1937.777.24.5.3.8' \
--header 'Prefer: handling=strict' --header "Authorization: Bearer $ACCESS_TOKEN"
```
You should get the following response: The search-param with code `mii-provision-provision-code` and type `Consent` was not found

7. Restore the initial custom-search-parameters.json `mv custom-search-parameters-backup.json custom-search-parameters.json`

8. stop and start Blaze again `docker compose stop && docker compose up -d`
9. Once the server has started up execute the following curl request:

```sh
curl 'http://localhost:8081/fhir/Consent?mii-provision-provision-code=2.16.840.1.113883.3.1937.777.24.5.3.8&_summary=count' \
--header 'Prefer: handling=strict' --header "Authorization: Bearer $ACCESS_TOKEN"
```
You should get a search set with 0 entries - The search parameter is now there, but the existing resources are not re-indexd

10. Trigger the re-indexing by deleting the index and restarting Blaze
- 10.1. `docker exec fhir-server_fhir-server_1 mv /app/data/index /app/data/index-old`
- 10.2. `docker compose stop && docker compose up -d`

11. Once the server has started up execute the following curl request:

```sh
curl 'http://localhost:8081/fhir/Consent?mii-provision-provision-code=2.16.840.1.113883.3.1937.777.24.5.3.8&_summary=count' \
--header 'Prefer: handling=strict' --header "Authorization: Bearer $ACCESS_TOKEN"
```
You should get a search set with 4992 entries - The search parameter is now there, and the indices have been rebuild
