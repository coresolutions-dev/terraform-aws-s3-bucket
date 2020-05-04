module "logging_example" {
    source                = "coresolutions-ltd/s3-bucket/aws"
    logging_target_bucket = "log_bucket"
    logging_target_prefix = "log/"
}