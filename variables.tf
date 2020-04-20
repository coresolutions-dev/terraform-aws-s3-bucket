variable "bucket_name" {
    type = string
}


variable "acl" {
    type    = string
    default = "private"
}

variable "versioning" {
    type    = bool
    default = false
}

variable "encryption" {
    type    = bool
    default = false
}

variable "tags" {
    type = map(string)
}