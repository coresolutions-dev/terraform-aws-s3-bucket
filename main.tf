resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name
    acl    = var.acl
    tags   = var.tags

    versioning {
        enabled = var.versioning
    }

    dynamic "server_side_encryption_configuraton" {
        for_each = tobool(var.encryption) ? [ var.encryption ] : []

        content {
            rule {
                apply_server_side_encryption_by_default {
                    sse_algorithm = "AES256"
                }
            }
        }
    }
} 