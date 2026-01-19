resource "aws_route53_zone" "primary" {
  count   = var.create_hosted_zone ? 1 : 0
  name    = var.domain_name
  comment = var.hosted_zone_comment

  tags = local.tags
}

data "aws_route53_zone" "existing_by_id" {
  count  = var.create_hosted_zone || var.hosted_zone_id == "" ? 0 : 1
  zone_id = var.hosted_zone_id
}

data "aws_route53_zone" "existing_by_name" {
  count       = var.create_hosted_zone || var.hosted_zone_id != "" ? 0 : 1
  name        = var.domain_name
  private_zone = false
}

locals {
  route53_zone_id = var.create_hosted_zone ? aws_route53_zone.primary[0].zone_id : (
    var.hosted_zone_id != ""
    ? data.aws_route53_zone.existing_by_id[0].zone_id
    : data.aws_route53_zone.existing_by_name[0].zone_id
  )
}

resource "aws_route53_record" "apex_a" {
  zone_id = local.route53_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.site.domain_name
    zone_id                = aws_cloudfront_distribution.site.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "apex_aaaa" {
  zone_id = local.route53_zone_id
  name    = var.domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.site.domain_name
    zone_id                = aws_cloudfront_distribution.site.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_a" {
  count   = var.create_www_record ? 1 : 0
  zone_id = local.route53_zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.site.domain_name
    zone_id                = aws_cloudfront_distribution.site.hosted_zone_id
    evaluate_target_health = false
  }
}
