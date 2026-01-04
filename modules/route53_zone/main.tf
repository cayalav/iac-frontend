locals {
  using_existing_id   = !var.create_zone && var.existing_zone_id != ""
  using_existing_name = !var.create_zone && !local.using_existing_id && var.existing_zone_name != ""
}

resource "aws_route53_zone" "this" {
  count = var.create_zone ? 1 : 0

  name          = var.zone_name
  comment       = var.comment
  force_destroy = var.force_destroy
  tags          = var.tags
}

data "aws_route53_zone" "existing_by_id" {
  count = local.using_existing_id ? 1 : 0

  zone_id = var.existing_zone_id
}

data "aws_route53_zone" "existing_by_name" {
  count = local.using_existing_name ? 1 : 0

  name         = var.existing_zone_name != "" ? var.existing_zone_name : var.zone_name
  private_zone = false
}

locals {
  zone_id = var.create_zone ? aws_route53_zone.this[0].zone_id : (
    local.using_existing_id ? data.aws_route53_zone.existing_by_id[0].zone_id : data.aws_route53_zone.existing_by_name[0].zone_id
  )

  zone_name = var.create_zone ? aws_route53_zone.this[0].name : (
    local.using_existing_id ? data.aws_route53_zone.existing_by_id[0].name : data.aws_route53_zone.existing_by_name[0].name
  )

  name_servers = var.create_zone ? aws_route53_zone.this[0].name_servers : (
    local.using_existing_id ? data.aws_route53_zone.existing_by_id[0].name_servers : data.aws_route53_zone.existing_by_name[0].name_servers
  )
}
