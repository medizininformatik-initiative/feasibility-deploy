library "3-Laboratory"
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0'

codesystem loinc: 'http://loinc.org'

context Patient

define "Criterion 1":
  exists [Observation: Code '718-7' from loinc]

define "Criterion 2":
  exists [Observation: Code '17856-6' from loinc]

define "Criterion 3":
  exists [Observation: Code '4548-4' from loinc]

define "Criterion 4":
  exists [Observation: Code '4549-2' from loinc]

define InInitialPopulation:
  "Criterion 1" or
  "Criterion 2" or
  "Criterion 3" or
  "Criterion 4"
