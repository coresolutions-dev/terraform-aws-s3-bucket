resource "aws_s3_bucket" "bucket" {
    # bucket = var.bucket_name
    bucket_prefix = var.prefix ? var.bucket_name : null
    bucket        = var.prefix ? null : var.bucket_name
    acl    = var.acl
    tags   = var.tags

    versioning {
        enabled = var.versioning
    }

    dynamic "server_side_encryption_configuration" {
        for_each = var.encryption ? [ var.encryption ] : []

        content {
            rule {
                apply_server_side_encryption_by_default {
                    sse_algorithm = "AES256"
                }
            }
        }
    }
} 
