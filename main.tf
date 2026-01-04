locals {
  computed_zone_name = var.hosted_zone_name != "" ? var.hosted_zone_name : var.domain_name

  default_tags = merge({
    Project     = var.project_name
    Environment = var.environment
  }, var.tags)

  site_bucket_name = var.site_bucket_name != "" ? var.site_bucket_name : lower(
    regexreplace("${var.project_name}-${var.environment}-frontend", "[^a-z0-9-]", "-")
  )
}

module "route53_zone" {
  source = "./modules/route53_zone"

  create_zone          = var.create_hosted_zone
  zone_name            = local.computed_zone_name
  comment              = var.hosted_zone_comment
  force_destroy        = var.hosted_zone_force_destroy
  existing_zone_id     = var.hosted_zone_id
  existing_zone_name   = local.computed_zone_name
  tags                 = local.default_tags
}

module "acm_certificate" {
  source = "./modules/acm_certificate"

  providers = {
    aws          = aws
    aws.us_east_1 = aws.us_east_1
  }

  domain_name                  = var.domain_name
  alternative_names            = var.alternate_domain_names
  hosted_zone_id               = module.route53_zone.zone_id
  create_validation_records    = var.create_acm_validation_records
  validation_record_ttl        = var.acm_validation_record_ttl
  tags                         = local.default_tags
}

module "static_site_bucket" {
  source = "./modules/s3_static_site"

  bucket_name        = local.site_bucket_name
  enable_versioning  = var.s3_enable_versioning
  force_destroy      = var.s3_force_destroy
  tags               = local.default_tags
}

module "cloudfront" {
  source = "./modules/cloudfront_distribution"

  bucket_id                 = module.static_site_bucket.bucket_id
  bucket_arn                = module.static_site_bucket.bucket_arn
  bucket_domain_name        = module.static_site_bucket.bucket_domain_name
  certificate_arn           = module.acm_certificate.certificate_arn
  domain_name               = var.domain_name
  alternate_domain_names    = var.alternate_domain_names
  default_root_object       = var.default_root_object
  price_class               = var.price_class
  compress_objects          = var.compress_objects
  default_ttl               = var.default_ttl
  min_ttl                   = var.min_ttl
  max_ttl                   = var.max_ttl
  geo_restriction_type      = var.geo_restriction_type
  geo_restriction_locations = var.geo_restriction_locations
  enable_logging            = var.enable_cloudfront_logging
  logging_bucket_domain_name = var.logging_bucket_domain_name
  logging_prefix            = var.logging_prefix
  tags                      = local.default_tags
}

module "route53_records" {
  source = "./modules/route53_records"

  zone_id                    = module.route53_zone.zone_id
  apex_record_name           = var.domain_name
  apex_target_domain_name    = module.cloudfront.domain_name
  apex_target_hosted_zone_id = module.cloudfront.hosted_zone_id
  create_www_record          = var.create_www_record
  www_record_name            = "${var.www_subdomain}.${var.domain_name}"
  www_target_domain_name     = module.cloudfront.domain_name
  www_target_hosted_zone_id  = module.cloudfront.hosted_zone_id
}
