output "site_bucket_name" {
  value       = aws_s3_bucket.site.bucket
  description = "Name of the S3 bucket that stores the site assets."
}

output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.site.id
  description = "Identifier of the CloudFront distribution."
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.site.domain_name
  description = "CloudFront domain name serving the site."
}

output "route53_zone_id" {
  value       = local.route53_zone_id
  description = "Hosted zone ID used for DNS records."
}

output "route53_name_servers" {
  value       = var.create_hosted_zone ? aws_route53_zone.primary[0].name_servers : []
  description = "List of name servers when a hosted zone is created by this stack."
}
