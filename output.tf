output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.cloudfront.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution identifier"
  value       = module.cloudfront.distribution_id
}

output "static_site_bucket_name" {
  description = "Primary S3 bucket for the frontend"
  value       = module.static_site_bucket.bucket_id
}

output "certificate_arn" {
  description = "Issued ACM certificate ARN"
  value       = module.acm_certificate.certificate_arn
}

output "route53_zone_id" {
  description = "Route53 hosted zone identifier"
  value       = module.route53_zone.zone_id
}

output "route53_name_servers" {
  description = "Route53 hosted zone name servers (useful when a zone was created)"
  value       = module.route53_zone.name_servers
}

output "apex_record_fqdn" {
  description = "Fully qualified domain name of the apex Route53 record"
  value       = module.route53_records.apex_record_fqdn
}
