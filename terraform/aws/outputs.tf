output "s3_bucket_name" {
  value       = aws_s3_bucket.website.id
  description = "Name of the S3 bucket for static website hosting"
}

output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.website.id
  description = "CloudFront distribution ID"
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.website.domain_name
  description = "CloudFront distribution domain name"
}

output "site_url" {
  value       = "https://${var.fqdn}"
  description = "Website URL"
}

output "certificate_arn" {
  value       = aws_acm_certificate_validation.cert.certificate_arn
  description = "ACM certificate ARN"
}

output "waf_web_acl_arn" {
  value       = aws_wafv2_web_acl.cloudfront.arn
  description = "AWS WAF Web ACL ARN for CloudFront"
}

output "waf_web_acl_id" {
  value       = aws_wafv2_web_acl.cloudfront.id
  description = "AWS WAF Web ACL ID"
}
