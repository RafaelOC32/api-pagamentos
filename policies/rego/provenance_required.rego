package supply.provenance

import rego.v1

deny contains msg if {
  not input.predicateType
  msg := "atestacao sem predicateType"
}

deny contains msg if {
  input.predicateType != "https://slsa.dev/provenance/v1"
  msg := sprintf("predicateType invalido: %v", [input.predicateType])
}

deny contains msg if {
  not input.predicate.builder.id
  msg := "builder.id ausente na provenance"
}

deny contains msg if {
  not input.subject
  msg := "subject ausente na provenance"
}