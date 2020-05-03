module "replication_example" {
  source     = "../"
  versioning = true

  replication_rules = [{
    id     = "foo"
    prefix = "foo"
    status = "Enabled"

    destination = {
      bucket        = module.destination_bucket.bucket_arn
      storage_class = "STANDARD"
    }
  },
  {
    id     = "bar"
    prefix = "bar"
    status = "Enabled"

    destination = {
      bucket        = module.destination_bucket.bucket_arn
      storage_class = "GLACIER"
    }
  }]
}

module "destination_bucket" {
  source     = "../"
  versioning = true
}
