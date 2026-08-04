package supply.provenance

deny[msg] {
    not input.provenance
    msg := "SLSA Provenance obrigatorio"
}