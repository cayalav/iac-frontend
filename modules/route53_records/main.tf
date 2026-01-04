resource "aws_route53_record" "apex" {
  count = var.apex_target_domain_name != "" && var.apex_target_hosted_zone_id != "" ? 1 : 0

  zone_id = var.zone_id
  name    = var.apex_record_name
  type    = "A"

  alias {
    name                   = var.apex_target_domain_name
    zone_id                = var.apex_target_hosted_zone_id
    evaluate_target_health = var.apex_evaluate_target_health
  }
}

resource "aws_route53_record" "www" {
  count = var.create_www_record && var.www_record_name != "" && var.www_target_domain_name != "" && var.www_target_hosted_zone_id != "" ? 1 : 0

  zone_id = var.zone_id
  name    = var.www_record_name
  type    = "A"

  alias {
    name                   = var.www_target_domain_name
    zone_id                = var.www_target_hosted_zone_id
    evaluate_target_health = var.www_evaluate_target_health
  }
}
