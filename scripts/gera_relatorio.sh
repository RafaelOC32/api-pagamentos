#!/bin/bash
set -euo pipefail

MES=$(date +%Y-%m)
REPO="${GITHUB_REPOSITORY:-/api-pagamentos}"
IMAGE_BASE="ghcr.io/$REPO"

mkdir -p "relatorios/$MES"

echo "Coletando releases do mes $MES"

gh release list --limit 50 --json tagName,publishedAt \
  | jq --arg m "$MES" '.[] | select(.publishedAt | startswith($m))' \
  > "relatorios/$MES/releases.json"

echo "tag,assinatura_ok,sbom_cyclonedx_ok,sbom_spdx_ok,provenance_ok" > "relatorios/$MES/conformidade.csv"

jq -r '.tagName' "relatorios/$MES/releases.json" | while read -r TAG; do
  IMG="$IMAGE_BASE:$TAG"

  SIG_OK=$(cosign verify "$IMG" \
    --certificate-identity-regexp "^https://github.com/$REPO/.*" \
    --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
    > /dev/null 2>&1 && echo "sim" || echo "nao")

  SBOM_CDX_OK=$(cosign verify-attestation "$IMG" \
    --type cyclonedx \
    --certificate-identity-regexp "^https://github.com/$REPO/.*" \
    --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
    > /dev/null 2>&1 && echo "sim" || echo "nao")

  SBOM_SPDX_OK=$(cosign verify-attestation "$IMG" \
    --type spdx \
    --certificate-identity-regexp "^https://github.com/$REPO/.*" \
    --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
    > /dev/null 2>&1 && echo "sim" || echo "nao")

  PROV_OK=$(cosign verify-attestation "$IMG" \
    --type slsaprovenance \
    --certificate-identity-regexp "^https://github.com/$REPO/.*" \
    --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
    > /dev/null 2>&1 && echo "sim" || echo "nao")

  echo "$TAG,$SIG_OK,$SBOM_CDX_OK,$SBOM_SPDX_OK,$PROV_OK" >> "relatorios/$MES/conformidade.csv"
done

echo "Relatorio gerado em relatorios/$MES/conformidade.csv"
cat "relatorios/$MES/conformidade.csv"