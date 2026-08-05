#!/bin/bash
set -euo pipefail

SBOM_FILE="${1:-sbom.cdx.json}"
PROJECT_VERSION="${2:-v0.0.0}"
PROJECT_NAME="${DT_PROJECT_NAME:-api-pagamentos}"

echo "Dependency-Track submission"
echo "Projeto: $PROJECT_NAME"
echo "Versao: $PROJECT_VERSION"
echo "SBOM: $SBOM_FILE"

if [ -n "${DTRACK_API_URL:-}" ] && [ -n "${DTRACK_API_KEY:-}" ]; then
  echo "Modo: real"

  curl -X POST "${DTRACK_API_URL}/api/v1/bom" \
    -H "X-Api-Key: ${DTRACK_API_KEY}" \
    -F "autoCreate=true" \
    -F "projectName=${PROJECT_NAME}" \
    -F "projectVersion=${PROJECT_VERSION}" \
    -F "bom=@${SBOM_FILE}"

  echo "SBOM submetido ao Dependency-Track"
else
  echo "Modo: mock"
  echo "[MOCK] Enviaria ${SBOM_FILE} para ${PROJECT_NAME}:${PROJECT_VERSION}"
  echo "[MOCK] Endpoint: /api/v1/bom"
  echo "[MOCK] Resultado: submissao simulada com sucesso"
fi