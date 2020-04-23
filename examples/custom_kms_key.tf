resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

module "custom_kms_key_example" {
    source      = "../"
    bucket_name = "custom-kms-bucket"
    encryption  = true
    kms_key     = aws_kms_key.mykey.arn
}