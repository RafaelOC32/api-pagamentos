package supply.image

import rego.v1

deny contains msg if {
  not input.image
  msg := "imagem nao informada"
}

deny contains msg if {
  image := input.image
  not startswith(image, "ghcr.io/")
  msg := sprintf("imagem fora do registry permitido: %v", [image])
}

deny contains msg if {
  image := input.image
  contains(image, ":latest")
  msg := "tag latest nao permitida"
}