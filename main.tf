resource "aws_s3_bucket" "bucket" {
    bucket_prefix = var.prefix ? var.bucket_name : null
    bucket        = var.prefix ? null : var.bucket_name
    acl           = var.acl
    tags          = var.tags

    versioning {
        enabled = var.versioning
    }

    dynamic "server_side_encryption_configuration" {
        for_each = var.encryption ? [ var.encryption ] : []

        content {
            rule {
                apply_server_side_encryption_by_default {
                    sse_algorithm     = var.kms_key == "" ? "AES256" : "aws:kms"
                    kms_master_key_id = var.kms_key == "" ? "" : var.kms_key
                }
            }
        }
    }
} 
