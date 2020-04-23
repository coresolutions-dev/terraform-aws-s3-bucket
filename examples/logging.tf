module "logging_example" {
    source                = "../"
    logging_target_bucket = "log_bucket"
    logging_target_prefix = "log/"
}