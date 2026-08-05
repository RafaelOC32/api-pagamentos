package supply.sbom

import rego.v1

deny contains msg if {
  not input.bomFormat
  msg := "SBOM sem campo bomFormat"
}

deny contains msg if {
  input.bomFormat != "CycloneDX"
  msg := sprintf("SBOM em formato invalido: %v", [input.bomFormat])
}

deny contains msg if {
  not input.components
  msg := "SBOM sem lista de componentes"
}

deny contains msg if {
  input.components
  count(input.components) == 0
  msg := "SBOM sem componentes"
}