resource "aws_cloudfront_distribution" "subdomain_distribution" {
    origin {
      domain_name = aws_s3_bucket.resume_bucket.bucket_regional_domain_name
      origin_access_control_id = aws_cloudfront_origin_access_control.subdomain_oac.id
      origin_id = aws_s3_bucket_website_configuration.website_config.website_endpoint
    }
    aliases = [ "www.chongyl.com" ]
    default_cache_behavior {
      allowed_methods = [ "GET", "HEAD" ]
      cached_methods = [ "GET", "HEAD" ]
      cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
      target_origin_id = aws_s3_bucket_website_configuration.website_config.website_endpoint
      compress = true
      viewer_protocol_policy = "redirect-to-https"
    }
    default_root_object = "index.html"
    enabled = true
    is_ipv6_enabled = true
    restrictions {
      geo_restriction {
        restriction_type = "none"
        locations = []
      }
    }
    viewer_certificate {
      acm_certificate_arn = aws_acm_certificate.ssl_cert.arn
      cloudfront_default_certificate = false
      minimum_protocol_version = "TLSv1.2_2021"
      ssl_support_method = "sni-only"
    }
    price_class = "PriceClass_All"
}

resource "aws_cloudfront_origin_access_control" "subdomain_oac" {
    name = "yow-lim-cloud-resume-bucket-origin-access-control"
    description = "Allow CloudFront to access the \"yow-lim-cloud-resume-bucket\" S3 bucket."
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
}

resource "aws_acm_certificate" "ssl_cert" {
    domain_name = "chongyl.com"
    provider = aws.ue1
}

resource "aws_cloudfront_distribution" "domain_distribution" {
    origin {
      domain_name = aws_s3_bucket_website_configuration.domain_website_config.website_endpoint
      origin_id = aws_s3_bucket.domain_bucket.bucket_regional_domain_name
      custom_origin_config {
        http_port                = 80
        https_port               = 443
        origin_keepalive_timeout = 5
        origin_protocol_policy   = "http-only"
        origin_read_timeout      = 30
        origin_ssl_protocols     = [ "SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2" ]
      }
    }
    aliases = [ "chongyl.com" ]
    default_cache_behavior {
      allowed_methods = [ "GET", "HEAD" ]
      cached_methods = [ "GET", "HEAD" ]
      cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
      target_origin_id = aws_s3_bucket.domain_bucket.bucket_regional_domain_name
      compress = true
      viewer_protocol_policy = "redirect-to-https"
    }
    enabled = true
    is_ipv6_enabled = true
    restrictions {
      geo_restriction {
        restriction_type = "none"
        locations = []
      }
    }
    viewer_certificate {
      acm_certificate_arn = aws_acm_certificate.ssl_cert.arn
      cloudfront_default_certificate = false
      minimum_protocol_version = "TLSv1.2_2021"
      ssl_support_method = "sni-only"
    }
    price_class = "PriceClass_All"
}