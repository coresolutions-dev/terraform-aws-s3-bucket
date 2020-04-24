[![alt text](https://coresolutions.ltd/media/core-solutions-82.png "Core Solutions")](https://coresolutions.ltd)

[![maintained by Core Solutions](https://img.shields.io/badge/maintained%20by-coresolutions.ltd-00607c.svg)](https://coresolutions.ltd)
[![GitHub tag](https://img.shields.io/github/v/tag/coresolutions-ltd/terraform-aws-s3-bucket.svg?label=latest)](https://github.com/coresolutions-ltd/terraform-aws-s3-bucket/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.20-623ce4.svg)](https://github.com/hashicorp/terraform/releases)
[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

# Core S3 Bucket Terraform Module

Terraform module which creates an S3 bucket whilst extrapolating as much complexity as possible.

## Getting Started

```sh
module "basic" {
    source = "../"
    bucket_name = "bucket-name"
    prefix = true
}
```

More examples can be found [here](https://github.com/coresolutions-ltd/terraform-aws-s3-bucket/tree/master/examples).


## Inputs


|          Name          |                                            Description                                              |    Type     | Default | Required |
| ---------------------- | --------------------------------------------------------------------------------------------------- | ----------- | --------| ---------|
| bucket_name            | Name for the bucket, if omitted, Terraform will assign a random unique name.                        | string      | None    | No       |
| prefix                 | If true sets bucket_name to bucket_prefix                                                           | bool        | false   | No       |
| acl                    | [Canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply **(Conflicts with grant)**  | string      | private | No       |
| grants                 | A list of [ACL Policy grants ](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#sample-acl) to apply **(Conflicts with acl)** | list(map)      | None | No       |
| policy                 | The bucket policy in JSON                                                                           | string      | None    | No       |
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
| tags                   | Map of tags to apply                                                                                | map(string) | None    | No       |


### Maps in the grants list supports the following, all must be of type `string`:
| Key | Value | Required |
| ----|------| --------- |
| type | Type of grantee to apply for, valid values are `CanonicalUser` and `Group` AmazonCustomerByEmail is not supported | Yes |
| permissions | permissions to apply for grantee. Valid values are `READ` `WRITE` `READ_ACP` `WRITE_ACP` `FULL_CONTROL` | Yes |
| id  | Canonical user id to grant for, used only when type is CanonicalUser | No |
| uri | Uri address to grant for. Used only when type is Group | No |


## Outputs

|             Name               |           Description           |
| ------------------------------ | ------------------------------- |
| s3_bucket_arn                  | Bucket ARN                      |
| s3_bucket_id                   | Bucket ID/Name                  |
| s3_bucket_region               | The bucket region               |
| s3_bucket_domain_name          | The bucket domain name          |
| s3_bucket_regional_domain_name | The regional bucket domain name |
| s3_bucket_hosted_zone_id       | The buckets hosted zone ID      |
