module "cors_rules_example" {
  source      = "coresolutions-ltd/s3-bucket/aws"

  cors_rules = [{
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://example1.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  },
  {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["https://example2.com"]
  }]
}
