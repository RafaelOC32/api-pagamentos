package supply.license

import rego.v1

test_allow_mit_license if {
  count(deny) == 0 with input as {
    "components": [
      {
        "name": "api-pagamentos",
        "licenses": [
          {
            "license": {
              "id": "MIT"
            }
          }
        ]
      }
    ]
  }
}

test_deny_gpl_license if {
  deny["componente lib-exemplo viola licenca proibida GPL-3.0-only"] with input as {
    "components": [
      {
        "name": "lib-exemplo",
        "licenses": [
          {
            "license": {
              "id": "GPL-3.0-only"
            }
          }
        ]
      }
    ]
  }
}