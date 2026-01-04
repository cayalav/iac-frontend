output "apex_record_fqdn" {
  description = "FQDN of the apex alias record"
  value       = try(aws_route53_record.apex[0].fqdn, null)
}

output "www_record_fqdn" {
  description = "FQDN of the www alias record"
  value       = try(aws_route53_record.www[0].fqdn, null)
}
