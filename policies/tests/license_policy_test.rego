package supply.license

test_license_blocked {
    result := deny with input as {
        "components": [{
            "name": "bad-lib",
            "licenses": [{
                "license": {
                    "id": "GPL-3.0-only"
                }
            }]
        }]
    }

    count(result) == 1
}

test_license_allowed {
    result := deny with input as {
        "components": [{
            "name": "good-lib",
            "licenses": [{
                "license": {
                    "id": "MIT"
                }
            }]
        }]
    }

    count(result) == 0
}