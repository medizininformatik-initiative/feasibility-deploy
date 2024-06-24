{
  duration: .extension[]
    | select(.url == "https://samply.github.io/blaze/fhir/StructureDefinition/eval-duration")
    | .valueQuantity.value,
  bloomFilterStats: {
     available: .extension[]
       | select(.url == "https://samply.github.io/blaze/fhir/StructureDefinition/bloom-filter-ratio")
       | .valueRatio.numerator.value,
     requested: .extension[]
       | select(.url == "https://samply.github.io/blaze/fhir/StructureDefinition/bloom-filter-ratio")
       | .valueRatio.denominator.value
  },
  result: .group[0].population[0].count
}
