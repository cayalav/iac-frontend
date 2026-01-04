# iac-frontend

Infrastructure-as-code stack that provisions the AWS primitives required to host a static frontend behind CloudFront with optional Route53 DNS management and ACM certificates.

## Prerequisites
- Terraform >= 1.3.0 installed locally.
- AWS account with permissions for ACM, CloudFront, Route53, and S3.
- Configured AWS credentials (environment variables or named profile).
- (Optional) Pre-existing S3 bucket and DynamoDB table for Terraform remote state if you do not want to use the provided placeholders.

## Getting Started
1. Clone the repository and change into the project directory.
2. Decide how you want to manage Terraform state. Update `backend.tf` with your S3 bucket, key, region, and DynamoDB lock table if applicable. Remove the block if you prefer local state.
3. Copy `terraform.tfvars.example` to a new file and customize it for the environment you are deploying:
	```bash
	cp terraform.tfvars.example prod.tfvars
	```
4. Review and adjust any values in `prod.tfvars`, paying particular attention to:
	- `domain_name` and `alternate_domain_names` for the certificate and CloudFront distribution.
	- `create_hosted_zone` and `hosted_zone_id` depending on whether the Route53 zone already exists.
	- `site_bucket_name` if you need a specific naming convention.
	- `enable_cloudfront_logging`, `logging_bucket_domain_name`, and `logging_prefix` if access logs are required.

## Terraform Workflow
Run Terraform commands from the repository root, supplying the tfvars file you prepared.

```bash
terraform init
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

Helpful tips:
- Use `-out plan.out` with `terraform plan` if you want to review before applying.
- Pass `-var profile=your-profile` or export `AWS_PROFILE` if you are not using the default profile.
- When `create_hosted_zone = true`, after `apply` copy the name servers returned in the outputs to your domain registrar.

## Module Overview
- `modules/route53_zone`: Creates or looks up the public hosted zone.
- `modules/acm_certificate`: Provisions an ACM certificate in `us-east-1` and, optionally, DNS validation records.
- `modules/s3_static_site`: Creates an S3 bucket that stores frontend artifacts with optional versioning.
- `modules/cloudfront_distribution`: Configures a CloudFront distribution backed by the S3 bucket and the ACM certificate.
- `modules/route53_records`: Adds apex and optional `www` aliases pointing to CloudFront.

## Outputs
After a successful `apply`, Terraform reports helpful values such as the CloudFront domain, distribution ID, hosted zone ID, and created record names. Reference `output.tf` for the full list.

## Cleaning Up
To tear everything down, run:

```bash
terraform destroy -var-file="prod.tfvars"
```

Set `s3_force_destroy = true` in your tfvars if you want Terraform to remove the S3 bucket even when objects remain.

## Additional Environments
- Duplicate your tfvars file (for example `testing.tfvars`) to model other environments.
- Tag resources via the `tags` map so you can distinguish environments in the AWS console and billing reports.
- Consider using workspaces or separate state files if you run multiple environments concurrently.

## Troubleshooting
- Validation of ACM certificates can take several minutes; rerun `terraform apply` if validation records were created mid-run.
- CloudFront distribution updates are asynchronous and may require time to deploy globally.
- If Route53 records already exist, import or remove them before applying to avoid conflicts.