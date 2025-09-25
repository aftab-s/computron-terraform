# S3 Bucket Outputs
output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.main.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket regional domain name"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}



output "bucket_tags" {
  description = "Tags assigned to the S3 bucket"
  value       = aws_s3_bucket.main.tags
}

output "bucket_versioning_status" {
  description = "The versioning status of the bucket"
  value       = aws_s3_bucket_versioning.main.versioning_configuration[0].status
}

output "bucket_summary" {
  description = "Summary of the S3 bucket configuration"
  value = {
    bucket_name         = aws_s3_bucket.main.id
    environment         = var.environment
    project            = var.project_name
    versioning_enabled = var.enable_versioning
    encryption_enabled = true
    public_access_blocked = var.block_public_access
    region            = var.aws_region
  }
}