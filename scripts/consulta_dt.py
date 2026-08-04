import requests

API_URL = "http://dependency-track:8080/api/v1/bom"

headers = {
    "X-Api-Key": "TOKEN"
}

with open("sbom.cdx.json", "rb") as f:
    response = requests.post(
        API_URL,
        headers=headers,
        files={"bom": f}
    )

print(response.status_code)
print(response.text)