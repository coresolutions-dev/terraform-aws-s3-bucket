module "basic_example" {
    source      = "coresolutions-ltd/s3-bucket/aws"
    bucket_name = "bucket-name"
    prefix      = true
}