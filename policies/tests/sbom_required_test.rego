package supply.sbom

test_missing_sbom {
    result := deny with input as {}

    count(result) == 1
}

test_sbom_present {
    result := deny with input as {
        "sbom": true
    }

    count(result) == 0
}