module "versioning_example" {
  source     = "coresolutions-ltd/s3-bucket/aws"
  versioning = true
  mfa_delete = true
}