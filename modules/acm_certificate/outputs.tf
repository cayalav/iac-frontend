output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.this.arn
}

output "certificate_id" {
  description = "ID of the ACM certificate"
  value       = aws_acm_certificate.this.id
}

output "validation_record_fqdns" {
  description = "List of DNS validation record FQDNs"
  value       = [for record in aws_route53_record.validation : record.fqdn]
}
