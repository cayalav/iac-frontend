###############################################################################
# General
###############################################################################
variable "region" {
  description = "AWS region to deploy primary resources"
  type        = string
}

variable "profile" {
  description = "Optional AWS named profile for authentication"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Human readable project identifier used for tagging"
  type        = string
}

variable "environment" {
  description = "Environment label appended to resource names"
  type        = string
  default     = "prod"
}

variable "tags" {
  description = "Additional tags to associate with all supported resources"
  type        = map(string)
  default     = {}
}

###############################################################################
# Domain & DNS
###############################################################################
variable "domain_name" {
  description = "Primary domain name served by CloudFront"
  type        = string
}

variable "alternate_domain_names" {
  description = "Additional domain names (SANs) for CloudFront and ACM"
  type        = list(string)
  default     = []
}

variable "create_hosted_zone" {
  description = "Create a public Route53 hosted zone for the domain"
  type        = bool
  default     = false
}

variable "hosted_zone_name" {
  description = "Hosted zone name when creating or looking up by name"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Existing Route53 hosted zone ID (skip creation when provided)"
  type        = string
  default     = ""
}

variable "hosted_zone_comment" {
  description = "Optional comment stored on the created hosted zone"
  type        = string
  default     = ""
}

variable "hosted_zone_force_destroy" {
  description = "Allow Terraform to delete the hosted zone even if records exist"
  type        = bool
  default     = false
}

variable "create_www_record" {
  description = "Create a www.<domain> alias pointing to CloudFront"
  type        = bool
  default     = true
}

variable "www_subdomain" {
  description = "Subdomain label used when create_www_record is true"
  type        = string
  default     = "www"
}

###############################################################################
# S3 Static Site
###############################################################################
variable "site_bucket_name" {
  description = "Explicit S3 bucket name for the frontend artifacts. Leave empty to autogenerate."
  type        = string
  default     = ""
}

variable "s3_force_destroy" {
  description = "Allow Terraform to delete the S3 bucket even when objects remain"
  type        = bool
  default     = false
}

variable "s3_enable_versioning" {
  description = "Enable versioning on the static site bucket"
  type        = bool
  default     = true
}

###############################################################################
# CloudFront
###############################################################################
variable "default_root_object" {
  description = "Default root object served by CloudFront"
  type        = string
  default     = "index.html"
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "compress_objects" {
  description = "Enable CloudFront compression for supported content types"
  type        = bool
  default     = true
}

variable "default_ttl" {
  description = "Default TTL (seconds) for cached objects"
  type        = number
  default     = 86400
}

variable "max_ttl" {
  description = "Maximum TTL (seconds) for cached objects"
  type        = number
  default     = 31536000
}

variable "min_ttl" {
  description = "Minimum TTL (seconds) for cached objects"
  type        = number
  default     = 0
}

variable "geo_restriction_type" {
  description = "Geo restriction strategy: none, whitelist, or blacklist"
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "ISO country codes applied when geo restriction is enabled"
  type        = list(string)
  default     = []
}

variable "enable_cloudfront_logging" {
  description = "Enable CloudFront access logging"
  type        = bool
  default     = false
}

variable "logging_bucket_domain_name" {
  description = "S3 bucket domain name that receives CloudFront logs (required when logging enabled)"
  type        = string
  default     = ""
}

variable "logging_prefix" {
  description = "Prefix applied to CloudFront access logs"
  type        = string
  default     = "cloudfront/"
}

###############################################################################
# ACM
###############################################################################
variable "create_acm_validation_records" {
  description = "Create Route53 validation records for the ACM certificate"
  type        = bool
  default     = true
}

variable "acm_validation_record_ttl" {
  description = "TTL (seconds) used for ACM validation DNS records"
  type        = number
  default     = 60
}
