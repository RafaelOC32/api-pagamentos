# api-pagamentos

Projeto de demonstração de práticas modernas de segurança e compliance aplicadas à cadeia de suprimentos de software (Software Supply Chain).

A aplicação é propositalmente simples e serve apenas como base para o pipeline. O foco principal deste repositório está na implementação de controles automatizados de segurança, geração de evidências e conformidade em um fluxo DevSecOps.

---

## Objetivo

Demonstrar como integrar segurança, rastreabilidade e conformidade diretamente ao processo de entrega de software.

O pipeline automatiza controles que ajudam a garantir que os artefatos publicados sejam verificáveis, auditáveis e acompanhem evidências de sua origem e composição.

---

## Funcionalidades

### Policy as Code

- Policies desenvolvidas em Rego utilizando Open Policy Agent (OPA)
- Testes automatizados das policies
- Execução das validações em Pull Requests
- Validação de:
  - Baseline de imagens
  - Licenças permitidas
  - Presença de SBOM
  - Provenance
  - Vulnerabilidades

### SBOM

- Geração automática de SBOM em formato CycloneDX
- Geração automática de SBOM em formato SPDX
- Publicação dos artefatos na Release do GitHub
- Integração simulada com Dependency-Track

### Segurança da Cadeia de Suprimentos

- Assinatura de imagens com Cosign Keyless
- Autenticação via GitHub OIDC
- Attestations de SBOM
- Attestations de vulnerabilidades
- SLSA Provenance

### Auditoria

- Evidências armazenadas em Releases
- Relatórios automatizados
- Histórico de execuções no GitHub Actions

---

## Estrutura do Projeto

```text
api-pagamentos/
│
├── .github/
│   └── workflows/
│       ├── pr-policy.yml
│       ├── release.yml
│       └── verify.yml
│
├── policies/
│   ├── rego/
│   │   ├── image_baseline.rego
│   │   ├── license_policy.rego
│   │   ├── provenance_required.rego
│   │   ├── sbom_required.rego
│   │   └── vuln_policy.rego
│   │
│   └── tests/
│       ├── image_baseline_test.rego
│       ├── license_policy_test.rego
│       ├── provenance_required_test.rego
│       ├── sbom_required_test.rego
│       └── vuln_policy_test.rego
│
├── k8s/
│   ├── deployment.yaml
│   └── policy-controller-policy.yaml
│
├── scripts/
│   ├── consulta_dt.py
│   ├── gera_relatorio.sh
│   └── submit_dependency_track.sh
│
├── .dockerignore
├── app.js
├── Dockerfile
├── package.json
└── README.md
```

---

## Aplicação

A aplicação foi mantida propositalmente simples para que o foco fique nos controles de segurança implementados no pipeline.

Executar localmente:

```bash
npm start
```

Saída esperada:

```text
api-pagamentos iniciada
Projeto DevSecOps ADA
Compliance contínuo em execução
```

---

## Docker

Build da imagem:

```bash
docker build -t api-pagamentos .
```

Executar container:

```bash
docker run --rm api-pagamentos
```

---

## Testes das Policies

Executar os testes OPA:

```bash
opa test policies/ -v
```

Resultado esperado:

```text
PASS
```

---

## Pipeline

O pipeline de release é executado automaticamente quando uma nova tag é criada.

Exemplo:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Fluxo executado:

```text
Tag
 │
 ▼
Build Docker
 │
 ▼
Push para GHCR
 │
 ▼
Geração de SBOM
 │
 ▼
Validação de Policies OPA
 │
 ▼
Análise de Vulnerabilidades
 │
 ▼
Assinatura da Imagem
 │
 ▼
Attestations
 │
 ▼
SLSA Provenance
 │
 ▼
Release no GitHub
```

---

## Workflows

### pr-policy.yml

Executado em Pull Requests.

Responsável por:

- Validar as policies Rego
- Executar os testes OPA

### release.yml

Executado em tags de versão.

Responsável por:

- Build da imagem
- Push para GHCR
- Geração de SBOM
- Trivy Scan
- Assinatura Cosign
- Geração de Attestations
- SLSA Provenance
- Criação da Release

### verify.yml

Executado manualmente.

Responsável por verificar:

- Assinatura da imagem
- Attestation CycloneDX
- Attestation SPDX
- SLSA Provenance

---

## Policies Implementadas

| Policy | Objetivo |
|----------|----------|
| image_baseline.rego | Restringe imagens fora do registry autorizado |
| license_policy.rego | Bloqueia licenças não permitidas |
| sbom_required.rego | Exige SBOM válido |
| provenance_required.rego | Exige provenance válida |
| vuln_policy.rego | Identifica vulnerabilidades críticas e altas |

---

## Evidências Geradas

Durante uma release são gerados os seguintes artefatos:

```text
sbom.cdx.json
sbom.spdx.json
trivy.json
```

Além disso:

- Assinatura Cosign da imagem
- Attestations associadas ao digest da imagem
- SLSA Provenance
- Logs da pipeline
- Release do GitHub

---

## Kubernetes

O diretório `k8s/` contém exemplos de deployment e políticas de admissão.

O objetivo é permitir que apenas imagens que atendam aos requisitos de segurança e conformidade sejam executadas no cluster.

---

## Auditoria

Gerar relatório de conformidade:

```bash
./scripts/gera_relatorio.sh
```

Saída:

```text
relatorios/YYYY-MM/conformidade.csv
```

O relatório consolida informações relacionadas a:

- Assinaturas
- Attestations
- Provenance
- Status das releases

---

## Tecnologias Utilizadas

- Node.js
- Docker
- GitHub Actions
- Open Policy Agent (OPA)
- Rego
- Trivy
- Cosign
- Sigstore
- SLSA
- CycloneDX
- SPDX
- GitHub Container Registry (GHCR)

---

## Mapeamento para Frameworks

| Controle | NIST SSDF | SLSA | ISO 27001 |
|-----------|-----------|-------|------------|
| OPA / Rego | PW.4 | Build Controls | A.8.9 |
| Geração de SBOM | PS.3 | Provenance Inputs | A.8.8 |
| Verificação de Licenças | PW.8 | Policy Enforcement | A.8.9 |
| Cosign Keyless | PW.6 | Artifact Signing | A.8.24 |
| SLSA Provenance | PO.3 | Level 3 Provenance | A.5.37 |
| Admission Gate | RV.1 | Deployment Controls | A.8.16 |
| Auditoria | PO.5 | Evidence Collection | A.5.35 |

---

## Publicação de Versões

Criar uma nova versão:

```bash
git tag v1.0.0
git push origin v1.0.0
```

A criação da tag dispara automaticamente o pipeline de release.

---

## Licença

Este projeto foi desenvolvido com fins educacionais e de demonstração de práticas DevSecOps, segurança da cadeia de suprimentos de software e automação de compliance.