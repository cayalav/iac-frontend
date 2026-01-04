provider "aws" {
  region  = var.region
  profile = var.profile != "" ? var.profile : null
}

provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = var.profile != "" ? var.profile : null
}
