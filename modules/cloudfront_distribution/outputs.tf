output "distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = aws_cloudfront_distribution.this.arn
}

output "domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "hosted_zone_id" {
  description = "Route53 hosted zone ID for the distribution"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}

output "origin_access_identity_id" {
  description = "Origin access identity ID"
  value       = aws_cloudfront_origin_access_identity.this.id
}
