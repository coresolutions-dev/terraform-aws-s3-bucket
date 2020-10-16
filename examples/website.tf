module "website_example" {
  source                 = "coresolutions-ltd/s3-bucket/aws"
  website_index_document = "index.html"
  website_error_document = "error.html"
}
