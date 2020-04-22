![alt text](https://coresolutions.ltd/media/core-solutions-82.png "Core Solutions")

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


|     Name    |                                               Description                                           |    Type     | Default | Required |
| ----------- | --------------------------------------------------------------------------------------------------- | ----------- | --------| ---------|
| bucket_name | Name for the bucket, if omitted, Terraform will assign a random unique name.                        | string      | None    | No       |
| prefix      | If true sets bucket_name to bucket_prefix                                                           | bool        | false   | No       |
| acl         | [Canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply | string      | private | No       |
| versioning  | Boolean to enable versioning                                                                        | bool        | false   | No       |
| encryption  | Boolean to enable encryption                                                                        | bool        | true    | No       |
| tags        | Map of tags to apply                                                                                | map(string) | None    | No       |


## Outputs

|         Name                   |           Description           |
| ------------------------------ | ------------------------------- |
| s3_bucket_arn                  | Bucket ARN                      |
| s3_bucket_id                   | Bucket ID/Name                  |
| s3_bucket_region               | The bucket region               |
| s3_bucket_domain_name          | The bucket domain name          |
| s3_bucket_regional_domain_name | The regional bucket domain name |
| s3_bucket_hosted_zone_id       | The buckets hosted zone ID      |