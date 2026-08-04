package supply.image

deny[msg] {
    input.image.tag == "latest"
    msg := "uso da tag latest nao permitido"
}