#!/bin/bash
# scripts/gera_relatorio.sh
MES=$(date +%Y-%m)
mkdir -p relatorios/$MES

# Releases do mes
gh release list --limit 50 --json tagName,publishedAt \
  | jq --arg m "$MES" '.[] | select(.publishedAt | startswith($m))' \
  > relatorios/$MES/releases.json

# Para cada release: status de assinatura
jq -r '.tagName' relatorios/$MES/releases.json | while read TAG; do
    IMG="ghcr.io/empresa/api-pagamentos:$TAG"
    SIG_OK=$(cosign verify "$IMG" \
        --certificate-identity-regexp '^https://github.com/empresa/.*' \
        --certificate-oidc-issuer https://token.actions.githubusercontent.com \
        > /dev/null 2>&1 && echo "sim" || echo "nao")
    PROV_OK=$(cosign verify-attestation "$IMG" --type slsaprovenance \
        --certificate-identity-regexp '^https://github.com/empresa/.*' \
        --certificate-oidc-issuer https://token.actions.githubusercontent.com \
        > /dev/null 2>&1 && echo "sim" || echo "nao")
    echo "$TAG,$SIG_OK,$PROV_OK" >> relatorios/$MES/conformidade.csv
done

echo "Relatorio em relatorios/$MES/conformidade.csv"