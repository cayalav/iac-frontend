locals {
  origin_id   = "s3-origin-${var.bucket_id}"
  aliases     = distinct(compact(concat([var.domain_name], var.alternate_domain_names)))
  http_version = var.enable_http3 ? "http2and3" : "http2"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "s3_cors" {
  name = "Managed-CORS-S3Origin"
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Access identity for ${var.domain_name}"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AllowCloudFrontServiceAccess"

    principals {
      type        = "CanonicalUser"
      identifiers = [aws_cloudfront_origin_access_identity.this.s3_canonical_user_id]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${var.bucket_arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.comment
  aliases             = local.aliases
  default_root_object = var.default_root_object
  price_class         = var.price_class
  http_version        = local.http_version

  origin {
    domain_name = var.bucket_domain_name
    origin_id   = local.origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = local.origin_id
    viewer_protocol_policy = var.viewer_protocol_policy
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    compress               = var.compress_objects
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching_optimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.s3_cors.id
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = var.minimum_protocol_version
  }

  dynamic "logging_config" {
    for_each = var.enable_logging && var.logging_bucket_domain_name != "" ? [1] : []

    content {
      bucket          = var.logging_bucket_domain_name
      prefix          = var.logging_prefix
      include_cookies = false
    }
  }

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.allow_cloudfront]
}
