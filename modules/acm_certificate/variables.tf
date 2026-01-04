variable "domain_name" {
  description = "Primary domain name for the ACM certificate"
  type        = string
}

variable "alternative_names" {
  description = "Subject alternative names for the ACM certificate"
  type        = list(string)
  default     = []
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID used for DNS validation"
  type        = string
}

variable "create_validation_records" {
  description = "Whether to manage DNS validation records in Route53"
  type        = bool
  default     = true
}

variable "validation_record_ttl" {
  description = "TTL applied to ACM validation records"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Tags applied to the ACM certificate"
  type        = map(string)
  default     = {}
}
