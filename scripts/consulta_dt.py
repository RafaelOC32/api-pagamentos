import json
import os
from datetime import datetime, timezone

def main():
    projeto = os.getenv("DT_PROJECT_NAME", "api-pagamentos")
    versao = os.getenv("DT_PROJECT_VERSION", "v1.0.0")

    resultado = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "modo": "mock",
        "dependency_track": {
            "projectName": projeto,
            "projectVersion": versao,
            "bomSubmitted": True,
            "policyViolations": 0,
            "criticalVulnerabilities": 0,
            "highVulnerabilities": 0
        }
    }

    print(json.dumps(resultado, indent=2))

if __name__ == "__main__":
    main()