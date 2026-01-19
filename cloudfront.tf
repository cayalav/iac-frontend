resource "aws_cloudfront_origin_access_identity" "site" {
  comment = "${var.project_name}-${var.environment} static site"
}

resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.project_name}-${var.environment}"
  default_root_object = var.default_root_object
  price_class         = var.price_class
  aliases             = distinct(concat([var.domain_name], var.alternate_domain_names))

  origin {
    domain_name = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id   = "s3-site"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.site.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3-site"
    viewer_protocol_policy = "redirect-to-https"
    smooth_streaming       = false
    compress               = var.compress_objects
    default_ttl            = 3600
    max_ttl                = 86400
    min_ttl                = 0

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
    cloudfront_default_certificate = false
  }

  http_version = "http2"

  dynamic "logging_config" {
    for_each = var.enable_cloudfront_logging ? [1] : []

    content {
      bucket          = var.logging_bucket_domain_name
      include_cookies = false
      prefix          = var.logging_prefix
    }
  }

  tags = local.tags
}
