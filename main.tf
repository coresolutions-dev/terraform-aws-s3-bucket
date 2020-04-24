resource "aws_s3_bucket" "bucket" {
    bucket_prefix       = var.prefix ? var.bucket_name : null
    bucket              = var.prefix ? null : var.bucket_name
    acl                 = var.acl
    tags                = var.tags
    policy              = var.policy
    force_destroy       = var.force_destroy
    acceleration_status = var.acceleration_status 

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

    dynamic "grant" {
        for_each = var.grants != null ? var.grants : []

        content {
            type        = lookup(grant.value, "type")
            permissions = [ for permission in split(",", lookup(grant.value, "permissions")) : trimspace(permission) ]
            id          = lookup(grant.value, "id", null)
            uri         = lookup(grant.value, "uri", null)
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

    dynamic "website" {
        for_each = var.website_index_document != null ? [ var.website_index_document ] : []

        content {
            index_document = var.website_index_document
            error_document = var.website_error_document
            routing_rules = var.website_routing_rules  
        }
    } 

    dynamic "website" {
        for_each = var.website_redirect_all != null ? [ var.website_redirect_all ] : []

        content {
            redirect_all_requests_to = var.website_redirect_all 
        }
    }  
} 
