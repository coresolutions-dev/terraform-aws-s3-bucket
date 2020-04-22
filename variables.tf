variable "bucket_name" {
    type = string
    default = null
}

variable "prefix" {
    type = bool
    default = false
}

variable "acl" {
    description = "Canned ACL to apply: https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl"
    type    = string
    default = "private"
}

variable "versioning" {
    type    = bool
    default = false
}

variable "encryption" {
    type    = bool
    default = true
}

variable "tags" {
    type = map(string)
    default = null
}
