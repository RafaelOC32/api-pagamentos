package supply.image

import rego.v1

test_allow_ghcr_versioned_image if {
  count(deny) == 0 with input as {
    "image": "ghcr.io/RafaelOC32/api-pagamentos:v1.0.0"
  }
}

test_deny_missing_image if {
  deny["imagem nao informada"] with input as {}
}

test_deny_non_ghcr_registry if {
  deny["imagem fora do registry permitido: docker.io/library/nginx:1.25"] with input as {
    "image": "docker.io/library/nginx:1.25"
  }
}

test_deny_latest_tag if {
  deny["tag latest nao permitida"] with input as {
    "image": "ghcr.io/RafaelOC32/api-pagamentos:latest"
  }
}