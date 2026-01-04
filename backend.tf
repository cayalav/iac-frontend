terraform {
  backend "s3" {
    bucket        = "your-remote-state-bucket"
    key           = "iac-cloudfront/terraform.tfstate"
    region        = "us-east-1"
    use_lockfile  = true
    encrypt       = true
  }
}
