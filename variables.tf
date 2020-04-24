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
    default     = null
}

variable "grants" {
    description = "An ACL policy grant to apply: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#sample-acl"
    type        = list(map(any))
    default     = null
}

variable "policy" {
  description = "The bucket policy in JSON."
  type        = string
  default     = null
}

variable "versioning" {
    type    = bool
    default = false
}

variable "mfa_delete" {
    type = bool
    default = null
}

variable "force_destroy" {
    description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error"
    type = bool
    default = false
}

variable "acceleration_status" {
    description = "Used to Enable or Suspend Transfer Acceleration: https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html"
    type = string
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

variable "website_index_document" {
    description = "S3 returns this index document when requests are made to the root domain or any of the subfolders"
    type        = string
    default     = null
}

variable "website_error_document" {
    description = "An absolute path to the document to return in case of a 4XX error"
    type        = string
    default     = null
}

variable "website_redirect_all" {
    description = "A hostname to redirect all website requests for this bucket to"
    type        = string
    default     = null
}

variable "website_routing_rules" {
    description = "A json array containing routing rules describing redirect behavior and when redirects are applied"
    type        = string
    default     = null
}