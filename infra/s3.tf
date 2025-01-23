locals {
  s3_bucket_name        = "yow-lim-cloud-resume-bucket"
  s3_domain_bucket_name = "chongyl.com"
  subdomain_url         = "www.chongyl.com"
}

resource "aws_s3_bucket" "resume_bucket" {
  bucket = local.s3_bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
  bucket = aws_s3_bucket.resume_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = ""
      sse_algorithm     = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront_access" {
  bucket = aws_s3_bucket.resume_bucket.id
  policy = jsonencode(
    {
      Statement = [
        {
          Action = "s3:GetObject"
          Condition = {
            StringEquals = {
              "AWS:SourceArn" = "arn:aws:cloudfront::144421025322:distribution/E3HXVC6Z0OWUTT"
            }
          }
          Effect = "Allow"
          Principal = {
            Service = "cloudfront.amazonaws.com"
          }
          Resource = "arn:aws:s3:::yow-lim-cloud-resume-bucket/*"
          Sid      = "AllowCloudFrontServicePrincipalReadOnly"
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.resume_bucket.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket" "domain_bucket" {
  bucket = local.s3_domain_bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "domain_bucket_config" {
  bucket = aws_s3_bucket.domain_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = ""
      sse_algorithm     = "AES256"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_website_configuration" "domain_website_config" {
  bucket = aws_s3_bucket.domain_bucket.id
  redirect_all_requests_to {
    host_name = local.subdomain_url
    protocol  = "https"
  }
}

resource "aws_s3_bucket_policy" "domain_allow_cloudfront_access" {
  bucket = aws_s3_bucket.domain_bucket.id
  policy = jsonencode(
    {
      Statement = [
        {
          Action = "s3:GetObject"
          Condition = {
            StringEquals = {
              "AWS:SourceArn" = "arn:aws:cloudfront::144421025322:distribution/EAWCFKPNQS8LQ"
            }
          }
          Effect = "Allow"
          Principal = {
            Service = "cloudfront.amazonaws.com"
          }
          Resource = "arn:aws:s3:::chongyl.com/*"
          Sid      = "AllowCloudFrontServicePrincipalReadOnly"
        },
      ]
      Version = "2012-10-17"
    }
  )
}