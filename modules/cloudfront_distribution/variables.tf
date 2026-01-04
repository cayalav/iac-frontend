variable "bucket_id" {
  description = "ID (name) of the S3 origin bucket"
  type        = string
}

variable "bucket_arn" {
  description = "ARN of the S3 origin bucket"
  type        = string
}

variable "bucket_domain_name" {
  description = "Regional domain name of the S3 origin bucket"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN bound to the CloudFront distribution"
  type        = string
}

variable "domain_name" {
  description = "Primary domain alias for the distribution"
  type        = string
}

variable "alternate_domain_names" {
  description = "Additional aliases for the distribution"
  type        = list(string)
  default     = []
}

variable "default_root_object" {
  description = "Default root object served by CloudFront"
  type        = string
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
}

variable "compress_objects" {
  description = "Enable origin compression"
  type        = bool
  default     = true
}

variable "default_ttl" {
  description = "Default TTL for cached objects"
  type        = number
}

variable "max_ttl" {
  description = "Maximum TTL for cached objects"
  type        = number
}

variable "min_ttl" {
  description = "Minimum TTL for cached objects"
  type        = number
}

variable "geo_restriction_type" {
  description = "Geo restriction configuration"
  type        = string
}

variable "geo_restriction_locations" {
  description = "List of country codes for geo restrictions"
  type        = list(string)
  default     = []
}

variable "enable_logging" {
  description = "Enable CloudFront access logs"
  type        = bool
  default     = false
}

variable "logging_bucket_domain_name" {
  description = "S3 bucket domain name that stores access logs"
  type        = string
  default     = ""
}

variable "logging_prefix" {
  description = "Prefix inside the logging bucket"
  type        = string
  default     = "cloudfront/"
}

variable "viewer_protocol_policy" {
  description = "Viewer protocol policy for the default cache behavior"
  type        = string
  default     = "redirect-to-https"
}

variable "allowed_methods" {
  description = "Allowed HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "Cached HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "minimum_protocol_version" {
  description = "Minimum TLS protocol version for viewers"
  type        = string
  default     = "TLSv1.2_2021"
}

variable "enable_http3" {
  description = "Enable HTTP/3 support"
  type        = bool
  default     = true
}

variable "comment" {
  description = "Optional description for the distribution"
  type        = string
  default     = "Static frontend distribution"
}

variable "tags" {
  description = "Tags applied to the CloudFront distribution"
  type        = map(string)
  default     = {}
}
