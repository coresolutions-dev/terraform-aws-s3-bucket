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
  description = "A list of ACL policy grants to apply: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#sample-acl"
  type        = any
  default     = []
}

variable "policy" {
  description = "The bucket policy in JSON."
  type        = string
  default     = null
}

variable "region" {
  description = "The AWS region this bucket should reside in, if omitted the region by the callee is used"
  type        = string
  default     = null
}

variable "request_payer" {
  description = "Who pays the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester"
  type        = string
  default     = "BucketOwner"
}

variable "versioning" {
  type    = bool
  default = false
}

variable "mfa_delete" {
  type    = bool
  default = false
}

variable "force_destroy" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
  default     = false
}

variable "acceleration_status" {
  description = "Used to Enable or Suspend Transfer Acceleration: https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html"
  type        = string
  default     = null
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
  type    = string
  default = null
}

variable "logging_target_prefix" {
  type    = string
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

variable "cors_rules" {
  description = "A list of CORS (cross-origin resource sharing) rules"
  type        = any
  default     = []
}

variable "lifecycle_rules" {
  description = "A list of object lifecycle rules"
  type        = any
  default     = []
}

variable "replication_rules" {
  description = "A list of objects containing replication configuration rules"
  type        = any
  default     = []
}

variable "replication_role" {
  description = "The ARN of the IAM role for Amazon S3 to assume when replicating objects"
  type        = string
  default     = null
}

variable "object_lock_configuration" {
  description = "The Object Lock Configuration you want to apply to the bucket"
  type        = any
  default     = null
}
