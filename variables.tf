variable "region" {
  type        = string
  description = "AWS region to deploy regional resources."
}

variable "project_name" {
  type        = string
  description = "Project identifier used in tagging."
}

variable "environment" {
  type        = string
  description = "Environment identifier used in tagging."
}

variable "domain_name" {
  type        = string
  description = "Primary domain name served by CloudFront."
}

variable "alternate_domain_names" {
  type        = list(string)
  description = "Additional domain aliases for the CloudFront distribution."
  default     = []
}

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate in us-east-1 for CloudFront."
}

variable "create_hosted_zone" {
  type        = bool
  description = "Whether to create a public Route 53 hosted zone for the domain."
  default     = false
}

variable "hosted_zone_comment" {
  type        = string
  description = "Comment applied to the hosted zone when created."
  default     = "Managed by Terraform"
}

variable "hosted_zone_id" {
  type        = string
  description = "Existing Route 53 hosted zone ID when not creating a new zone."
  default     = ""
}

variable "create_www_record" {
  type        = bool
  description = "Whether to create a www CNAME/alias record pointing to the distribution."
  default     = false
}

variable "site_bucket_name" {
  type        = string
  description = "Unique name of the S3 bucket that stores the site assets."
}

variable "s3_force_destroy" {
  type        = bool
  description = "Allow Terraform to delete the bucket even when it holds objects."
  default     = false
}

variable "s3_enable_versioning" {
  type        = bool
  description = "Enable object versioning on the site bucket."
  default     = true
}

variable "default_root_object" {
  type        = string
  description = "Default object served by CloudFront when no specific file is requested."
  default     = "index.html"
}

variable "price_class" {
  type        = string
  description = "CloudFront price class to limit the edge locations used."
  default     = "PriceClass_100"
}

variable "compress_objects" {
  type        = bool
  description = "Enable automatic HTTP compression by CloudFront."
  default     = true
}

variable "geo_restriction_type" {
  type        = string
  description = "CloudFront geo restriction type: none, whitelist, or blacklist."
  default     = "none"
}

variable "geo_restriction_locations" {
  type        = list(string)
  description = "List of country codes used with geo restrictions."
  default     = []
}

variable "enable_cloudfront_logging" {
  type        = bool
  description = "Enable access logging for the CloudFront distribution."
  default     = false
}

variable "logging_bucket_domain_name" {
  type        = string
  description = "Domain name of the S3 bucket that stores CloudFront logs. Required when logging is enabled."
  default     = ""
}

variable "logging_prefix" {
  type        = string
  description = "Prefix applied to CloudFront access logs."
  default     = "cloudfront/"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags applied to all taggable resources."
  default     = {}
}
