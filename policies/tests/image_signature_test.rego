package supply.signature

test_unsigned_image {
    result := deny with input as {}

    count(result) == 1
}

test_signed_image {
    result := deny with input as {
        "signed": true
    }

    count(result) == 0
}