package supply.provenance

import rego.v1

test_allow_valid_slsa_provenance if {
  count(deny) == 0 with input as {
    "predicateType": "https://slsa.dev/provenance/v1",
    "predicate": {
      "builder": {
        "id": "https://github.com/actions/runner"
      }
    },
    "subject": [
      {
        "name": "ghcr.io/RafaelOC32/api-pagamentos",
        "digest": {
          "sha256": "abc123"
        }
      }
    ]
  }
}

test_deny_missing_predicate_type if {
  deny["atestacao sem predicateType"] with input as {
    "predicate": {
      "builder": {
        "id": "https://github.com/actions/runner"
      }
    },
    "subject": []
  }
}

test_deny_invalid_predicate_type if {
  deny["predicateType invalido: https://exemplo.com/predicate"] with input as {
    "predicateType": "https://exemplo.com/predicate",
    "predicate": {
      "builder": {
        "id": "https://github.com/actions/runner"
      }
    },
    "subject": []
  }
}

test_deny_missing_builder if {
  deny["builder.id ausente na provenance"] with input as {
    "predicateType": "https://slsa.dev/provenance/v1",
    "predicate": {},
    "subject": []
  }
}