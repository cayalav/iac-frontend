output "zone_id" {
  description = "Route53 hosted zone ID"
  value       = local.zone_id
}

output "zone_name" {
  description = "Route53 hosted zone name"
  value       = local.zone_name
}

output "name_servers" {
  description = "Name servers for the hosted zone"
  value       = local.name_servers
}
