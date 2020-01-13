locals {
  aws_hosted_cloudfront_zone_id = "Z2FDTNDATAQYW2"
  google_gsuite_hosted_cname    = "ghs.googlehosted.com."
  bucket_name                   = var.alias_name == "" ? var.zone_name : "${var.alias_name}.${var.zone_name}"
  website_domain                = "s3-website.${var.aws_region}.amazonaws.com"
  website_endpoint              = "${local.bucket_name}.${local.website_domain}"
  distribution_origin_id        = "S3-Website-${local.website_endpoint}"
}

resource "aws_s3_bucket" "bucket_index" {
  count            = var.redirection_url == "" ? 1 : 0
  bucket           = local.bucket_name
  hosted_zone_id   = var.aws_s3_bucket_hosted_zone_id
  region           = var.aws_region
  request_payer    = "BucketOwner"
  tags             = {}
  website_domain   = local.website_domain
  website_endpoint = local.website_endpoint

  versioning {
    enabled    = false
    mfa_delete = false
  }

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "bucket_redirect" {
  count            = var.redirection_url == "" ? 0 : 1
  bucket           = local.bucket_name
  hosted_zone_id   = var.aws_s3_bucket_hosted_zone_id
  region           = var.aws_region
  request_payer    = "BucketOwner"
  tags             = {}
  website_domain   = local.website_domain
  website_endpoint = local.website_endpoint

  versioning {
    enabled    = false
    mfa_delete = false
  }

  website {
    redirect_all_requests_to = var.redirection_url
  }
}

resource "aws_s3_bucket_policy" "edith_care" {
  count  = var.enable_public_access ? 1 : 0
  bucket = local.bucket_name
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "s3:GetObject"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "arn:aws:s3:::${local.bucket_name}/*"
          Sid       = "PublicReadGetObject"
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_cloudfront_distribution" "edith_care" {
  aliases = [
    local.bucket_name
  ]
  enabled             = true
  http_version        = "http2"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  tags                = {}
  wait_for_deployment = true

  default_cache_behavior {
    allowed_methods = [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT",
    ]
    cached_methods = [
      "GET",
      "HEAD",
    ]
    compress               = false
    default_ttl            = 86400
    max_ttl                = 31536000
    min_ttl                = 0
    smooth_streaming       = false
    target_origin_id       = local.distribution_origin_id
    trusted_signers        = []
    viewer_protocol_policy = var.viewer_protocol_policy

    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []

      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
  }

  origin {
    domain_name = local.website_endpoint
    origin_id   = local.distribution_origin_id

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.aws_cert_arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.1_2016"
    ssl_support_method             = "sni-only"
  }
}

resource "aws_route53_record" "edith_care" {
  name    = local.bucket_name
  type    = "A"
  zone_id = var.aws_zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.edith_care.domain_name
    zone_id                = local.aws_hosted_cloudfront_zone_id
  }
}

