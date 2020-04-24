variable "bucket_name" {
    type    = string
    default = null
}

variable "prefix" {
    type    = bool
    default = false
}

variable "acl" {
    description = "Canned ACL to apply: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl"
    type        = string
    default     = "private"
}

variable "versioning" {
    type    = bool
    default = false
}

variable "mfa_delete" {
    type = bool
    default = null
}

variable "encryption" {
    type    = bool
    default = true
}

variable "kms_key" {
    description = "ARN of the KMS key to use, if omitted and encryption is set to true SSE-S3 is used."
    type        = string
    default     = ""
}

variable "tags" {
    type    = map(string)
    default = null
}

variable "logging_target_bucket" {
    type = string
    default = null
}

variable "logging_target_prefix" {
    type = string
    default = null
}

variable "policy" {
  description = "The bucket policy in JSON."
  type        = string
  default     = null
}