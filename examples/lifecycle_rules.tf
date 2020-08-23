module "lifecycle_rules_example" {
  source = "coresolutions-ltd/s3-bucket/aws"

  lifecycle_rules = [{
    id      = "log"
    enabled = true
    prefix  = "log/"

    tags = {
      "rule"      = "log"
      "autoclean" = "true"
    }

    transitions = [{
      days          = 30
      storage_class = "STANDARD_IA"
      },
      {
        days          = 60
        storage_class = "GLACIER"
    }]

    expiration = {
      days = 90
    }
  }]
}


module "lifecycle_rules_versioned_example" {
  source = "coresolutions-ltd/s3-bucket/aws"

  acl        = "private"
  versioning = true

  lifecycle_rules = [{
    prefix  = "config/"
    enabled = true

    noncurrent_version_transitions = [{
      days          = 30
      storage_class = "STANDARD_IA"
      },
      {
        days          = 60
        storage_class = "GLACIER"
    }]

    noncurrent_version_expiration = {
      days = 90
    }
  }]
}
