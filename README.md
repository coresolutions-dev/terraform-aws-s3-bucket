[![alt text](https://coresolutions.ltd/media/core-solutions-82.png "Core Solutions")](https://coresolutions.ltd)

[![maintained by Core Solutions](https://img.shields.io/badge/maintained%20by-coresolutions.ltd-00607c.svg)](https://coresolutions.ltd)
[![GitHub tag](https://img.shields.io/github/v/tag/coresolutions-ltd/terraform-aws-s3-bucket.svg?label=latest)](https://github.com/coresolutions-ltd/terraform-aws-s3-bucket/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.20-623ce4.svg)](https://github.com/hashicorp/terraform/releases)
[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

# S3 Bucket Terraform Module

Terraform module which creates an S3 bucket whilst extrapolating as much complexity as possible.

## Getting Started

```sh
module "basic" {
    source  = "coresolutions-ltd/s3-bucket/aws"

    bucket_name = "bucket-name"
    prefix      = true
}
```

More examples can be found [here](https://github.com/coresolutions-ltd/terraform-aws-s3-bucket/tree/master/examples).


## Inputs


|          Name          |                                            Description                                              |    Type     | Default | Required |
| ---------------------- | --------------------------------------------------------------------------------------------------- | ----------- | --------| ---------|
| bucket_name            | Name for the bucket, if omitted, Terraform will assign a random unique name.                        | string      | None    | No       |
| prefix                 | If true creates a unique bucket name beginning with the specified bucket_name                  | bool        | false   | No       |
| acl                    | [Canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply **(Conflicts with grant)**  | string      | private | No       |
| grants                 | A list of [ACL Policy grants ](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#sample-acl) to apply **(Conflicts with acl)** | list(object)      | None | No       |
| policy                 | The bucket policy in JSON                                                                           | string      | None     | No       |
| request_payer          | Who pays the cost of Amazon S3 data transfer. Can be either `BucketOwner` or `Requester`            | string      | BucketOwner | No    |
| force_destroy          | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error | bool      | false    | No       |
| acceleration_status    | Used to enable or suspend [Transfer Acceleration](https://docs.aws.amazon.com/AmazonS3/latest/dev/transfer-acceleration.html). Value can be `Enabled` or `Suspended`            | string      | None    | No       |
| versioning             | Boolean to enable versioning                                                                        | bool        | false   | No       |
| mfa_delete             | Boolean to enable MFA Delete on versioned bucket                                                    | bool        | false   | No       |
| encryption             | Boolean to enable encryption                                                                        | bool        | true    | No       |
| kms_key                | ARN of the KMS key to use, if omitted and **encryption** is set to true SSE-S3 is used              | string      | None    | No       |
| logging_target_bucket  | The name of the bucket that will receive the log objects                                            | string      | None    | No       |
| logging_target_prefix  | key prefix for log objects                                                                          | string      | None    | No       |
| website_index_document | S3 returns this index document when requests are made to the root domain or any of the subfolders **(Conflicts with website_redirect_all)**   | string      | None    | No       |
| website_error_document | An absolute path to the document to return in case of a 4XX error                                   | string      | None    | No       |
| website_redirect_all   | A hostname to redirect all website requests for this bucket to                                      | string      | None    | No       |
| website_routing_rules  | A json array containing routing rules describing redirect behavior and when redirects are applied   | string      | None    | No       |
| cors_rules             | A list of CORS (cross-origin resource sharing) rules (documented below)                             | list(object)| None    | No       |
| lifecycle_rules        | A list of object lifecycle rules (documented below)                                                 | list(object)| None    | No       |
| replication_role       | The ARN of the IAM role for Amazon S3 to assume when replicating objects, if omitted with rules specified in `replication_rules` a role will be created automatically as `CoreS3ReplicationRole_BUCKETNAME` | string | None | No |
| replication_rules      | Objects containing replication configuration rules (documented below)                               | list(object)| None    | No       |
| object_lock_configuration | The Object Lock Configuration you want to apply to the bucket (documented below)                 | object      | None    | No       |
| tags                   | Map of tags to apply                                                                                | map(string) | None    | No       |


### Objects in the **grants** list support the following:
| Key         |                                                      Value                                                        | Type         | Required  |
| ----------- |------------------------------------------------------------------------------------------------------------------ | ------------ | --------- |
| type        | Type of grantee to apply for, valid values are `CanonicalUser` and `Group` AmazonCustomerByEmail is not supported | string       | Yes       |
| permissions | List of permissions to apply for grantee. Valid values are `READ` `WRITE` `READ_ACP` `WRITE_ACP` `FULL_CONTROL`   | list(string) | Yes       |
| id          | Canonical user id to grant for, used only when type is CanonicalUser                                              | string       | No        |
| uri         | Uri address to grant for. Used only when type is Group                                                            | string       | No        |

### Objects in the **cors_rules** list support the following:
| Key             |                                         Value                                             | Type         | Required  |
| --------------- |------------------------------------------------------------------------------------------ | ------------ | --------- |
| allowed_headers | Specifies which headers are allowed                                                       | list(string) | Yes       |
| allowed_methods | Specifies which methods are allowed. Can be GET, PUT, POST, DELETE or HEAD                | list(string) | Yes       |
| allowed_origins | Specifies which origins are allowed                                                       | list(string) | No        |
| expose_headers  | Specifies expose header in the response                                                   | list(string) | No        |
| max_age_seconds | Specifies time in seconds that browser can cache the response for a preflight request     | number       | No        |


### Objects in the **lifecycle_rules** list support the following:
| Key                                    |                                              Value                                                 | Type    | Required |
| -------------------------------------- | -------------------------------------------------------------------------------------------------- | ------- | -------- |
| enabled                                | Specifies lifecycle rule status                                                                    | bool        | Yes |
| id                                     | Unique identifier for the rule                                                                     | string      | No |
| prefix                                 | Object key prefix identifying one or more objects to which the rule applies                        | string      | No |
| tags                                   | Specifies object tags key and value                                                                | map(string) | No |
| abort_incomplete_multipart_upload_days | The number of days after initiating a multipart upload when the multipart upload must be completed | number      | No |
| transitions                            | List of transition objects to apply (documented below)                                             | object      | No |
| noncurrent_version_transitions         | Specifies when noncurrent object versions transitions (documented below)                           | object      | No |
| noncurrent_version_expiration          | Specifies when noncurrent object versions expire (documented below)                                | object      | No |
| expiration                             | Specifies when an object expires (documented below)                                                | object      | No |

At least one of `expiration` `transition` `noncurrent_version_expiration` `noncurrent_version_transition` must be specified, see object details below

### Objects in the lifecycle_rules(**transitions**) list support the following:
| Key                                    |                                              Value                                                 | Type    | Required |
| -------------------------------------- | -------------------------------------------------------------------------------------------------- | ------- | -------- |
| storage_class | Specifies the storage class to which you want the object to transition. Can be `ONEZONE_IA` `STANDARD_IA` `INTELLIGENT_TIERING` `GLACIER` or `DEEP_ARCHIVE` | string | Yes |
| date | Specifies the date after which you want the corresponding action to take effect               | string | No |
| days | Specifies the number of days after object creation when the specific rule action takes effect | number | No |

### Objects in the lifecycle_rules(**noncurrent_version_transitions**) object support the following:
| Key           |                                              Value                                          | Type    | Required |
| ------------- | ------------------------------------------------------------------------------------------- | ------- | -------- |
| storage_class | Specifies the Amazon S3 storage class to which you want the noncurrent versions object to transition. Can be `ONEZONE_IA` `STANDARD_IA` `INTELLIGENT_TIERING` `GLACIER` or `DEEP_ARCHIVE` | string | Yes |
| days | Specifies the number of days an object is noncurrent object versions expire | number | Yes |

### The lifecycle_rules(**noncurrent_version_expiration**) object support the following:
| Key  |                                     Value                                   |  Type  | Required |
| ---- | --------------------------------------------------------------------------- | ----- | -------- |
| days | Specifies the number of days an object is noncurrent object versions expire | number | Yes      |

### The lifecycle_rules(**expiration**) object support the following:
| Key                           |                                              Value                                                 | Type    | Required |
| ----------------------------- | -------------------------------------------------------------------------------------------------- | ------- | -------- |
| date                          | Specifies the date after which you want the corresponding action to take effect                    | string  | No       |
| days                          | Specifies the number of days after object creation when the specific rule action takes effect      | number  | No       |
| expired_object_delete_marker  | On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycleconfiguration to direct S3 to delete expired object delete markers | bool | No

### Objects in the **replication_rules** list support the following:
| Key                          |                                             Value                                                         | Type | Required |
| -------------------------    | --------------------------------------------------------------------------------------------------------- | ------ | ------ |
| destination                  | Specifies the destination for the rule (documented below)                                                 | object | Yes    |
| status                       | The status of the rule. Either Enabled or Disabled. The rule is ignored if status is not Enabled          | string | Yes    |
| id                           | Unique identifier for the rule                                                                            | string | No     |
| priority                     | The priority associated with the rule, default is 0, must be unique between multiple rules                | number | No     |
| replicate_kms_encrypted_objects  | If `true` replicate SSE-KMS encrypted objects, `replica_kms_key_id` in the destination object must also be specified, default value is `false` | bool | No |
| prefix                       | Object keyname prefix identifying one or more objects to which the rule applies                           | string | No     |
| filter                       | Filter that identifies subset of objects to which the replication rule applies (documented below)         | object | No     |

### The replication_rules(**destination**) object support the following:
| Key   |                               Value                             | Type | Required |
| ----- | --------------------------------------------------------------- | ---- | -------- |
| bucket | The ARN of the S3 bucket where you want Amazon S3 to store replicas of the object identified by the rule | string | Yes |
| storage_class | The class of storage used to store the object. Can be `STANDARD` `REDUCED_REDUNDANCY` `STANDARD_IA` `ONEZONE_IA` `INTELLIGENT_TIERING` `GLACIER` or `DEEP_ARCHIVE` | string | No |
| replica_kms_key_id | Destination KMS encryption key ARN for SSE-KMS replication. Must be used in conjunction with `source_encrypted_objects` | string | No |


### The replication_rules(**filter**) object support the following:
| Key                       |                               Value                            | Type   | Required |
| ------------------------- | -------------------------------------------------------------- | ------ | -------- |
| prefix | Object keyname prefix that identifies subset of objects to which the rule applies | string | No       |
| tags   | A map of tags that identifies subset of objects to which the rule applies. The rule applies only to objects having all the tags in its tagset | map(string) | No |

### The **object_lock_configuration** object support the following:
| Key                 |                               Value                            | Type   | Default | Required |
| ------------------- | -------------------------------------------------------------- | ------ | ------- | -------- |
| object_lock_enabled | Boolean to enable [object locking](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock-overview.html) | bool | false | Yes |
| default_mode        | The default Object Lock retention mode you want to apply to new objects placed in this bucket. Valid values are `GOVERNANCE` and `COMPLIANCE` | string | None | No |
| default_days        | The number of days that you want to specify for the default retention period  | number | None | No |
| default_years       | The number of years that you want to specify for the default retention period | number | None | No |
> If setting a `default_mode` either `default_days` or `default_years` must be specified, but not both.

> **NOTE** on object_lock_configuration: You can only enable S3 Object Lock for new buckets. If you need to turn on S3 Object Lock for an existing bucket, please contact AWS Support. When you create a bucket with S3 Object Lock enabled, Amazon S3 automatically enables versioning for the bucket. Once you create a bucket with S3 Object Lock enabled, you can't disable Object Lock or suspend versioning for the bucket.

## Outputs
|             Name     |           Description           |
| -------------------- | ------------------------------- |
| arn                  | Bucket ARN                      |
| id                   | Bucket ID/Name                  |
| region               | The bucket region               |
| domain_name          | The bucket domain name          |
| regional_domain_name | The regional bucket domain name |
| hosted_zone_id       | The buckets hosted zone ID      |
