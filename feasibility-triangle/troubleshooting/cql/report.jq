{
  duration: .extension[]
    | select(.url == "https://samply.github.io/blaze/fhir/StructureDefinition/eval-duration")
    | .valueQuantity.value,
  bloomFilterStats: {
     available: (first(.extension[]
       | select(.url == "https://samply.github.io/blaze/fhir/StructureDefinition/bloom-filter-ratio")
       ).valueRatio?.numerator?.value // 0),
     requested: (first(.extension[]
       | select(.url == "https://samply.github.io/blaze/fhir/StructureDefinition/bloom-filter-ratio")
       ).valueRatio?.denominator?.value // 0)
  },
  result: .group[0].population[0].count
}
