package supply.sbom

deny[msg] {
    not input.sbom
    msg := "SBOM obrigatorio"
}