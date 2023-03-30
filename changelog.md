# Changelog

All notable changes to this project will be documented in this file.

## Component specific changes

Please refer to the respective repositories for a more in depth changelog of single components:

|Component|Link|
|--|--|
|UI|<https://github.com/medizininformatik-initiative/feasibility-gui>|
|Backend|<https://github.com/medizininformatik-initiative/feasibility-backend>|
|AKTIN Broker|<https://github.com/aktin/broker>|
|AKTIN Feasibility Plugin|<https://github.com/medizininformatik-initiative/feasibility-aktin-plugin>|
|DSF Feasibility Plugin|<https://github.com/medizininformatik-initiative/feasibility-dsf-process>|
|FLARE|<https://github.com/medizininformatik-initiative/flare>|
|Blaze FHIR server|<https://github.com/medizininformatik-initiative/blaze>|

## [2.0.0] - 2023-03-29

### Overall

- Updated all components and underlying libraries to the new versions
- Updated UI to angular 15
- Updated keycloak to 21.0
- Updated nginx to 1.23
- Refactored deploy repository - removed DSF from this deployment and added reference to DSF deployment in Readme
- Removed hapi fhir-server from deployment

### Features

| Feature | Affected Components |
| -- | -- |
|Added calculated criterion age|Ontology, Sq2cql, FLARE|
|Improved at site obfuscation|DSF Feasibility Plugin, AKTIN Client|
|Added SQ query import and export|UI|
|Improved FHIR query execution and result caching |FLARE|
|Update Consent to new search params and add central MII consent query|UI, Ontology|
|Update ontology to newest KDS version| Ontology|
|Update AKTIN client to new version, move query handling to Java plugin and add query validation|AKTIN client|
|SQ query validation|Backend, AKTIN client|
|Add CQL execution to direct broker| Backend|

### Security and Privacy

| Feature | Affected Components |
| - | - |
|Added extra security measures, which restrict number queries a user can send and results a user can view|UI, Backend|
|Improved at site obfuscation|DSF Feasibility Plugin, Aktin Client|
|Hard rate limit at sites for AKTIN and DSF feasibility plugins|DSF feasibility plugin, AKTIN Client|
|Query results are no longer persisted and only kept in memory for a configurable amount of time|Backend|
|Delete query results from central DSF and AKTIN broker on collection|Backend|
|User blacklisting if too many queries are sent in a given time|Backend|

## [1.6.0] - 2022-09-08
