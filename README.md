# api-pagamentos

Aplicacao  usada no projeto final integrador da ADA de compliance continuo em pipeline DevSecOps.

## Objetivo

Transformar o pipeline da aplicacao `api-pagamentos` em um sistema de compliance continuo, cobrindo:

- Policy as Code com Rego e OPA
- Testes automatizados de policies em Pull Request
- Geracao de SBOM em CycloneDX e SPDX
- Submissao de SBOM ao Dependency-Track, real ou mockada
- Assinatura de imagem com Cosign keyless via OIDC
- Atestacoes de SBOM, scan de vulnerabilidades e SLSA Provenance
- Gate de admissao no Kubernetes
- Relatorio mensal automatizado
- Evidencias para auditoria
