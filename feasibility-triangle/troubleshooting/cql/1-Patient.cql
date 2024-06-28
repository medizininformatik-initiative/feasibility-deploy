library "1-Patient"
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0'

context Patient

define Criterion:
  Patient.gender = 'female' or
  Patient.gender = 'male'

define InInitialPopulation:
  Criterion
