variable "bucket_name" {
  description = "Name for the S3 bucket that stores frontend artifacts"
  type        = string
}

variable "force_destroy" {
  description = "Allow Terraform to delete the bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = true
}

variable "enable_public_access_block" {
  description = "Apply public access block settings to the bucket"
  type        = bool
  default     = true
}

variable "website_configuration" {
  description = "Optional static website configuration for the bucket"
  type = object({
    index_document = string
    error_document = string
  })
  default = null
}

variable "tags" {
  description = "Tags applied to the S3 bucket"
  type        = map(string)
  default     = {}
}
