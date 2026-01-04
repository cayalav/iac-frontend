variable "create_zone" {
  description = "Create a new public Route53 hosted zone"
  type        = bool
}

variable "zone_name" {
  description = "DNS zone name used for creation or lookup"
  type        = string
}

variable "comment" {
  description = "Optional comment for the hosted zone"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Allow deletion of the hosted zone even if it still contains records"
  type        = bool
  default     = false
}

variable "existing_zone_id" {
  description = "Existing hosted zone ID when not creating a new one"
  type        = string
  default     = ""
}

variable "existing_zone_name" {
  description = "Existing hosted zone name used for lookup when ID is not provided"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to a newly created hosted zone"
  type        = map(string)
  default     = {}
}
