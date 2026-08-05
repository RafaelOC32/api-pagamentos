package supply.sbom

import rego.v1

test_allow_valid_cyclonedx_sbom if {
  count(deny) == 0 with input as {
    "bomFormat": "CycloneDX",
    "components": [
      {
        "name": "node",
        "version": "20"
      }
    ]
  }
}

test_deny_missing_bom_format if {
  deny["SBOM sem campo bomFormat"] with input as {
    "components": [
      {
        "name": "node"
      }
    ]
  }
}

test_deny_invalid_bom_format if {
  deny["SBOM em formato invalido: SPDX"] with input as {
    "bomFormat": "SPDX",
    "components": [
      {
        "name": "node"
      }
    ]
  }
}

test_deny_empty_components if {
  deny["SBOM sem componentes"] with input as {
    "bomFormat": "CycloneDX",
    "components": []
  }
}