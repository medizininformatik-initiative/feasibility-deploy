library "5-Consent"
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0'

codesystem consent_policy: 'urn:oid:2.16.840.1.113883.3.1937.777.24.5.3'

context Patient

define Criterion:
  exists (from [Consent] C
    where C.provision.provision.code.coding contains Code '2.16.840.1.113883.3.1937.777.24.5.3.8' from consent_policy)

define InInitialPopulation:
  Criterion
