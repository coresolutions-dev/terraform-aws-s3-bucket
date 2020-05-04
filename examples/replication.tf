module "replication_example" {
  source     = "coresolutions-ltd/s3-bucket/aws"
  versioning = true

  replication_rules = [{
    id     = "foo"
    status = "Enabled"

    destination = {
      bucket        = module.destination_bucket.bucket_arn
      storage_class = "STANDARD"
    }
  }
}

module "destination_bucket" {
  source     = "coresolutions-ltd/s3-bucket/aws"
  versioning = true
}
