package supply.image

test_latest_tag_denied {
    result := deny with input as {
        "image": {
            "tag": "latest"
        }
    }

    count(result) == 1
}

test_version_tag_allowed {
    result := deny with input as {
        "image": {
            "tag": "v1.0.0"
        }
    }

    count(result) == 0
}