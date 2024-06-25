library "4-Procedure"
using FHIR version '4.0.0'
include FHIRHelpers version '4.0.0'

codesystem oops: 'http://fhir.de/CodeSystem/bfarm/ops'

context Patient

define "Criterion 1":
  exists [Procedure: Code '3-20' from oops] or
  exists [Procedure: Code '3-20x' from oops] or
  exists [Procedure: Code '3-208' from oops] or
  exists [Procedure: Code '3-207' from oops] or
  exists [Procedure: Code '3-206' from oops] or
  exists [Procedure: Code '3-201' from oops] or
  exists [Procedure: Code '3-204' from oops] or
  exists [Procedure: Code '3-205' from oops] or
  exists [Procedure: Code '3-200' from oops] or
  exists [Procedure: Code '3-202' from oops] or
  exists [Procedure: Code '3-203' from oops]

define "Criterion 2":
  exists [Procedure: Code '8-19' from oops] or
  exists [Procedure: Code '8-192' from oops] or
  exists [Procedure: Code '8-192.1' from oops] or
  exists [Procedure: Code '8-192.1b' from oops] or
  exists [Procedure: Code '8-192.1a' from oops] or
  exists [Procedure: Code '8-192.1g' from oops] or
  exists [Procedure: Code '8-192.1d' from oops] or
  exists [Procedure: Code '8-192.15' from oops] or
  exists [Procedure: Code '8-192.19' from oops] or
  exists [Procedure: Code '8-192.1c' from oops] or
  exists [Procedure: Code '8-192.10' from oops] or
  exists [Procedure: Code '8-192.17' from oops] or
  exists [Procedure: Code '8-192.1e' from oops] or
  exists [Procedure: Code '8-192.16' from oops] or
  exists [Procedure: Code '8-192.1x' from oops] or
  exists [Procedure: Code '8-192.14' from oops] or
  exists [Procedure: Code '8-192.18' from oops] or
  exists [Procedure: Code '8-192.1f' from oops] or
  exists [Procedure: Code '8-192.3' from oops] or
  exists [Procedure: Code '8-192.3b' from oops] or
  exists [Procedure: Code '8-192.3a' from oops] or
  exists [Procedure: Code '8-192.3g' from oops] or
  exists [Procedure: Code '8-192.3d' from oops] or
  exists [Procedure: Code '8-192.35' from oops] or
  exists [Procedure: Code '8-192.39' from oops] or
  exists [Procedure: Code '8-192.3c' from oops] or
  exists [Procedure: Code '8-192.30' from oops] or
  exists [Procedure: Code '8-192.37' from oops] or
  exists [Procedure: Code '8-192.3e' from oops] or
  exists [Procedure: Code '8-192.36' from oops] or
  exists [Procedure: Code '8-192.3x' from oops] or
  exists [Procedure: Code '8-192.34' from oops] or
  exists [Procedure: Code '8-192.38' from oops] or
  exists [Procedure: Code '8-192.3f' from oops] or
  exists [Procedure: Code '8-192.2' from oops] or
  exists [Procedure: Code '8-192.2b' from oops] or
  exists [Procedure: Code '8-192.2a' from oops] or
  exists [Procedure: Code '8-192.2g' from oops] or
  exists [Procedure: Code '8-192.2d' from oops] or
  exists [Procedure: Code '8-192.25' from oops] or
  exists [Procedure: Code '8-192.29' from oops] or
  exists [Procedure: Code '8-192.2c' from oops] or
  exists [Procedure: Code '8-192.20' from oops] or
  exists [Procedure: Code '8-192.27' from oops] or
  exists [Procedure: Code '8-192.2e' from oops] or
  exists [Procedure: Code '8-192.26' from oops] or
  exists [Procedure: Code '8-192.2x' from oops] or
  exists [Procedure: Code '8-192.24' from oops] or
  exists [Procedure: Code '8-192.28' from oops] or
  exists [Procedure: Code '8-192.2f' from oops] or
  exists [Procedure: Code '8-192.0' from oops] or
  exists [Procedure: Code '8-192.0b' from oops] or
  exists [Procedure: Code '8-192.0a' from oops] or
  exists [Procedure: Code '8-192.0g' from oops] or
  exists [Procedure: Code '8-192.0d' from oops] or
  exists [Procedure: Code '8-192.05' from oops] or
  exists [Procedure: Code '8-192.09' from oops] or
  exists [Procedure: Code '8-192.0c' from oops] or
  exists [Procedure: Code '8-192.00' from oops] or
  exists [Procedure: Code '8-192.07' from oops] or
  exists [Procedure: Code '8-192.0e' from oops] or
  exists [Procedure: Code '8-192.06' from oops] or
  exists [Procedure: Code '8-192.0x' from oops] or
  exists [Procedure: Code '8-192.04' from oops] or
  exists [Procedure: Code '8-192.08' from oops] or
  exists [Procedure: Code '8-192.0f' from oops] or
  exists [Procedure: Code '8-192.y' from oops] or
  exists [Procedure: Code '8-192.x' from oops] or
  exists [Procedure: Code '8-192.xb' from oops] or
  exists [Procedure: Code '8-192.xa' from oops] or
  exists [Procedure: Code '8-192.xg' from oops] or
  exists [Procedure: Code '8-192.xd' from oops] or
  exists [Procedure: Code '8-192.x5' from oops] or
  exists [Procedure: Code '8-192.x9' from oops] or
  exists [Procedure: Code '8-192.xc' from oops] or
  exists [Procedure: Code '8-192.x0' from oops] or
  exists [Procedure: Code '8-192.x7' from oops] or
  exists [Procedure: Code '8-192.xe' from oops] or
  exists [Procedure: Code '8-192.x6' from oops] or
  exists [Procedure: Code '8-192.xx' from oops] or
  exists [Procedure: Code '8-192.x4' from oops] or
  exists [Procedure: Code '8-192.x8' from oops] or
  exists [Procedure: Code '8-192.xf' from oops] or
  exists [Procedure: Code '8-190' from oops] or
  exists [Procedure: Code '8-190.2' from oops] or
  exists [Procedure: Code '8-190.22' from oops] or
  exists [Procedure: Code '8-190.21' from oops] or
  exists [Procedure: Code '8-190.20' from oops] or
  exists [Procedure: Code '8-190.23' from oops] or
  exists [Procedure: Code '8-190.4' from oops] or
  exists [Procedure: Code '8-190.42' from oops] or
  exists [Procedure: Code '8-190.41' from oops] or
  exists [Procedure: Code '8-190.40' from oops] or
  exists [Procedure: Code '8-190.43' from oops] or
  exists [Procedure: Code '8-190.3' from oops] or
  exists [Procedure: Code '8-190.32' from oops] or
  exists [Procedure: Code '8-190.31' from oops] or
  exists [Procedure: Code '8-190.30' from oops] or
  exists [Procedure: Code '8-190.33' from oops] or
  exists [Procedure: Code '8-191' from oops] or
  exists [Procedure: Code '8-191.1' from oops] or
  exists [Procedure: Code '8-191.11' from oops] or
  exists [Procedure: Code '8-191.10' from oops] or
  exists [Procedure: Code '8-191.2' from oops] or
  exists [Procedure: Code '8-191.21' from oops] or
  exists [Procedure: Code '8-191.20' from oops] or
  exists [Procedure: Code '8-191.0' from oops] or
  exists [Procedure: Code '8-191.01' from oops] or
  exists [Procedure: Code '8-191.00' from oops] or
  exists [Procedure: Code '8-191.5' from oops] or
  exists [Procedure: Code '8-191.y' from oops] or
  exists [Procedure: Code '8-191.7' from oops] or
  exists [Procedure: Code '8-191.72' from oops] or
  exists [Procedure: Code '8-191.73' from oops] or
  exists [Procedure: Code '8-191.74' from oops] or
  exists [Procedure: Code '8-191.75' from oops] or
  exists [Procedure: Code '8-191.76' from oops] or
  exists [Procedure: Code '8-191.77' from oops] or
  exists [Procedure: Code '8-191.78' from oops] or
  exists [Procedure: Code '8-191.79' from oops] or
  exists [Procedure: Code '8-191.71' from oops] or
  exists [Procedure: Code '8-191.70' from oops] or
  exists [Procedure: Code '8-191.6' from oops] or
  exists [Procedure: Code '8-191.x' from oops] or
  exists [Procedure: Code '8-191.4' from oops] or
  exists [Procedure: Code '8-191.41' from oops] or
  exists [Procedure: Code '8-191.40' from oops] or
  exists [Procedure: Code '8-191.3' from oops] or
  exists [Procedure: Code '8-191.31' from oops] or
  exists [Procedure: Code '8-191.30' from oops]

define InInitialPopulation:
  "Criterion 1" or
  "Criterion 2"
