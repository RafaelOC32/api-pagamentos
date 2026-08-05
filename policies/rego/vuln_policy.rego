package supply.vuln

import rego.v1

deny contains msg if {
  result := input.Results[_]
  vuln := result.Vulnerabilities[_]
  vuln.Severity == "CRITICAL"
  msg := sprintf("vulnerabilidade critica encontrada: %v", [vuln.VulnerabilityID])
}

deny contains msg if {
  result := input.Results[_]
  vuln := result.Vulnerabilities[_]
  vuln.Severity == "HIGH"
  not vuln.FixedVersion
  msg := sprintf("vulnerabilidade HIGH sem versao corrigida: %v", [vuln.VulnerabilityID])
}