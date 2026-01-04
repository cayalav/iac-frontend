variable "zone_id" {
  description = "Route53 hosted zone ID where records are created"
  type        = string
}

variable "apex_record_name" {
  description = "Record name for the apex alias"
  type        = string
}

variable "apex_target_domain_name" {
  description = "Alias target domain name"
  type        = string
}

variable "apex_target_hosted_zone_id" {
  description = "Alias target hosted zone ID"
  type        = string
}

variable "apex_evaluate_target_health" {
  description = "Evaluate target health on the apex alias"
  type        = bool
  default     = false
}

variable "create_www_record" {
  description = "Create a www alias record"
  type        = bool
  default     = true
}

variable "www_record_name" {
  description = "Record name for the www alias"
  type        = string
  default     = ""
}

variable "www_target_domain_name" {
  description = "Alias target domain name for www"
  type        = string
  default     = ""
}

variable "www_target_hosted_zone_id" {
  description = "Alias target hosted zone ID for www"
  type        = string
  default     = ""
}

variable "www_evaluate_target_health" {
  description = "Evaluate target health on the www alias"
  type        = bool
  default     = false
}
