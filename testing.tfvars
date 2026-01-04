region        = "us-east-1"
profile       = "default"
project_name  = "frontend"
environment   = "test"

domain_name            = "test.example.com"
alternate_domain_names = ["www.test.example.com"]
create_hosted_zone     = true
hosted_zone_comment    = "Testing zone managed by Terraform"
create_www_record      = true

site_bucket_name     = "frontend-test-example-com"
s3_force_destroy     = true
s3_enable_versioning = false

default_root_object  = "index.html"
price_class          = "PriceClass_100"
compress_objects     = true
geo_restriction_type = "none"

enable_cloudfront_logging  = false
logging_bucket_domain_name = ""
logging_prefix             = "cloudfront/"

create_acm_validation_records = true
acm_validation_record_ttl     = 60

tags = {
  Environment = "test"
  Owner       = "frontend-team"
}
