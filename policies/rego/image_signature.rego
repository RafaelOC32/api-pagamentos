package supply.signature

deny[msg] {
    not input.signed
    msg := "imagem nao assinada"
}