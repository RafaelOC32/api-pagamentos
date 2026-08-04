package supply.provenance

test_missing_provenance {
    result := deny with input as {}

    count(result) == 1
}

test_valid_provenance {
    result := deny with input as {
        "provenance": true
    }

    count(result) == 0
}