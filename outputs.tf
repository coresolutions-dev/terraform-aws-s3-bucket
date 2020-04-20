output "bucket_arn" {
    Description = "ARN of the S3 bucket"
    value       = aws_s3_bucket.bucket.arn
}

output "bucket_id" {
    Description = "Name of the S3 bucket"
    value       = aws_s3_bucket.bucket.id
}

output "bucket_region" {
    Description = "Region of the S3 bucket"
    value       = aws_s3_bucket.bucket.region
}

output "bucket_domain_name" {
    Description = "Domain name of the S3 bucket"
    value       = aws_s3_bucket.bucket.bucket_domain_name
}

output "bucket_regional_domain_name" {
    Description = "Regional domain name of the S3 bucket"
    value       = aws_s3_bucket.bucket.bucket_regional_domain_name
}

output "hosted_zone_id" {
    Description = "Zone ID of the S3 bucket"
    value       = aws_s3_bucket.bucket.zone_id
}