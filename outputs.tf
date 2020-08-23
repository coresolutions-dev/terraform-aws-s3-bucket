output "arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.bucket.arn
}

output "id" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.bucket.id
}

output "region" {
  description = "Region of the S3 bucket"
  value       = aws_s3_bucket.bucket.region
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = aws_s3_bucket.bucket.bucket_domain_name
}

output "regional_domain_name" {
  description = "Regional domain name of the S3 bucket"
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
}

output "hosted_zone_id" {
  description = "Zone ID of the S3 bucket"
  value       = aws_s3_bucket.bucket.hosted_zone_id
}
