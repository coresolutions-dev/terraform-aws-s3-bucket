locals {
    init_name = var.bucket_name != null ? var.bucket_name : "corebucket-${random_id.rand.0.dec}"
    bucket_name = var.prefix ? "${local.init_name}-${random_id.rand.0.dec}" : local.init_name
}

resource "random_id" "rand" {
    count = var.bucket_name == null || var.prefix == true ? 1 : 0
    byte_length = 4
}

resource "aws_s3_bucket" "bucket" {
    bucket              = local.bucket_name
    acl                 = var.acl
    tags                = var.tags
    policy              = var.policy
    force_destroy       = var.force_destroy
    acceleration_status = var.acceleration_status 
    region              = var.region
    request_payer       = var.request_payer 

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
        for_each = var.grants

        content {
            type        = grant.value.type
            permissions = grant.value.permissions
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

    dynamic "cors_rule" {
        for_each = var.cors_rules

        content {
            allowed_methods = cors_rule.value.allowed_methods
            allowed_origins = cors_rule.value.allowed_origins
            allowed_headers = lookup(cors_rule.value, "allowed_headers", null)
            expose_headers  = lookup(cors_rule.value, "expose_headers", null)
            max_age_seconds = lookup(cors_rule.value, "max_age_seconds", null)
            
        }
    }

    dynamic "lifecycle_rule" {
        for_each = var.lifecycle_rules

        content {
            enabled                                = lifecycle_rule.value.enabled
            id                                     = lookup(lifecycle_rule.value, "id", null)
            prefix                                 = lookup(lifecycle_rule.value, "prefix", null)
            tags                                   = lookup(lifecycle_rule.value, "tags", null)
            abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days", null)

            dynamic "transition" {
                for_each = lookup(lifecycle_rule.value, "transitions", [])

                content {
                    storage_class = transition.value.storage_class 
                    days          = lookup(transition.value, "days", null)
                    date          = lookup(transition.value, "date", null)
                }
            }

            dynamic "noncurrent_version_transition" {
                for_each = lookup(lifecycle_rule.value, "noncurrent_version_transitions", [])

                content {
                    storage_class = noncurrent_version_transition.value.storage_class 
                    days          = noncurrent_version_transition.value.days
                }
            }

            dynamic "noncurrent_version_expiration" {
                for_each = lookup(lifecycle_rule.value, "noncurrent_version_expiration", [])

                content {
                    days = noncurrent_version_expiration.value
                }
            }
            
            dynamic "expiration" {
                for_each = lookup(lifecycle_rule.value, "expiration", null ) != null ? [ lifecycle_rule.value.expiration ] : [] 

                content {
                    days                         = lookup(expiration.value, "days", null)
                    date                         = lookup(expiration.value, "date", null)
                    expired_object_delete_marker = lookup(expiration.value, "expired_object_delete_marker", null)
                }
            }
        }
    }

    dynamic "replication_configuration" {
        for_each = var.replication_rules != [] ? [1] : []

        content {
            role  = var.replication_role != null ? var.replication_role : aws_iam_role.replication.0.arn
            
            dynamic "rules" {
                for_each = var.replication_rules

                content {
                    status   = rules.value.status
                    id       = lookup(rules.value, "id", null)
                    priority = lookup(rules.value, "priority", null)
                    prefix   = lookup(rules.value, "prefix", null)

                    dynamic "source_selection_criteria" {
                        for_each = lookup(rules.value, "replicate_kms_encrypted_objects", false) ? [ rules.value.replicate_kms_encrypted_objects ] : []

                        content {
                            sse_kms_encrypted_objects {
                                enabled = rules.value.replicate_kms_encrypted_objects
                            }
                        }
                    }
                    
                    dynamic "destination" {
                        for_each = [ rules.value.destination ]

                        content {
                            bucket             = destination.value.bucket
                            storage_class      = lookup(destination.value, "storage_class", null)
                            replica_kms_key_id = lookup(destination.value, "replica_kms_key_id", null)
                            account_id         = lookup(destination.value, "account_id", null) 
                        }
                    }

                    dynamic "filter" {
                        for_each = lookup(rules.value, "filter", null) != null ? [ rules.value.filter ] : []

                        content {
                            prefix = lookup(filter.value, "prefix", null)
                            tags   = lookup(filter.value, "tags", null)
                        }
                    }
                }
            }
        }
    }
}

resource "aws_iam_role" "replication" {
    count      = var.replication_rules != [] && var.replication_role == null ? 1 : 0
    name       = "CoreS3ReplicationRole_${local.bucket_name}"

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

data "aws_iam_policy_document" "replication" {
    count = var.replication_rules != [] && var.replication_role == null ? 1 : 0

    statement {
        actions   = ["s3:GetReplicationConfiguration",
                     "s3:ListBucket"]
        resources = ["${aws_s3_bucket.bucket.arn}"]
    }

    statement {
        actions   = ["s3:GetObjectVersion",
                     "s3:GetObjectVersionAcl"]
        resources = ["${aws_s3_bucket.bucket.arn}/*"]
    }

    statement {
        actions   = ["s3:ReplicateObject",
                     "s3:ReplicateDelete"]
        resources = formatlist("%s/*",distinct([ for rule in var.replication_rules : lookup(rule, "destination").bucket ]))
    }
}

resource "aws_iam_policy" "replication" {
    count      = var.replication_rules != [] && var.replication_role == null ? 1 : 0
    name       = "CoreS3ReplicationPolicy_${local.bucket_name}"
    policy     = data.aws_iam_policy_document.replication.0.json
}

resource "aws_iam_role_policy_attachment" "replication" {
    count      = var.replication_rules != [] && var.replication_role == null ? 1 : 0
    role       = aws_iam_role.replication.0.name
    policy_arn = aws_iam_policy.replication.0.arn
}
