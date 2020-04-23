resource "aws_s3_bucket" "bucket" {
    bucket_prefix = var.prefix ? var.bucket_name : null
    bucket        = var.prefix ? null : var.bucket_name
    acl           = var.acl
    tags          = var.tags

    versioning {
        enabled    = var.versioning
        mfa_delete = var.mfa_delete
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

    dynamic "logging" {
        for_each = var.logging_target_bucket != null ? [ var.logging_target_bucket ] : []
        iterator = target_bucket

        content {
            target_bucket = target_bucket.value
            target_prefix = var.logging_target_prefix  
        }
  }


} 
