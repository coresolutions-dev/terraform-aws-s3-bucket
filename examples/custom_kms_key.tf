resource "aws_kms_key" "mykey" {
  description = "This key is used to encrypt bucket objects"
}

module "custom_kms_key_example" {
  source      = "coresolutions-ltd/s3-bucket/aws"
  bucket_name = "custom-kms-bucket"
  encryption  = true
  kms_key     = aws_kms_key.mykey.arn
}