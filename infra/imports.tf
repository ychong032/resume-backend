import {
  to = aws_s3_bucket.resume_bucket
  id = local.s3_bucket_name
}

import {
  to = aws_s3_bucket_policy.allow_cloudfront_access
  id = local.s3_bucket_name
}

import {
  to = aws_s3_bucket_website_configuration.website_config
  id = local.s3_bucket_name
}

import {
  to = aws_s3_bucket_server_side_encryption_configuration.encryption_config
  id = local.s3_bucket_name
}

# import {
#   for_each = fileset("${path.module}/../src", "**")
#   to = aws_s3_object.s3_objects[each.value]
#   id = "${local.s3_bucket_name}/${each.value}"
# }

import {
  to = aws_s3_bucket.domain_bucket
  id = local.s3_domain_bucket_name
}

import {
  to = aws_s3_bucket_policy.domain_allow_cloudfront_access
  id = local.s3_domain_bucket_name
}


import {
  to = aws_s3_bucket_website_configuration.domain_website_config
  id = local.s3_domain_bucket_name
}

import {
  to = aws_s3_bucket_server_side_encryption_configuration.domain_bucket_config
  id = local.s3_domain_bucket_name
}

import {
  to = aws_cloudfront_origin_access_control.subdomain_oac
  id = "E2S3RU9AIZIJ37"
}

import {
  to = aws_acm_certificate.ssl_cert
  id = "arn:aws:acm:us-east-1:144421025322:certificate/0092c721-712e-4975-87da-97d140cb4048"
}

import {
  to = aws_cloudfront_distribution.subdomain_distribution
  id = "E3HXVC6Z0OWUTT"
}

import {
  to = aws_cloudfront_distribution.domain_distribution
  id = "EAWCFKPNQS8LQ"
}

import {
  to = aws_route53_zone.primary
  id = "Z06241973U8PWJN4OXIOP"
}

import {
  to = aws_route53_record.domain
  id = "Z06241973U8PWJN4OXIOP_chongyl.com_A"
}

import {
  to = aws_route53_record.subdomain
  id = "Z06241973U8PWJN4OXIOP_www.chongyl.com_A"
}

import {
  to = aws_dynamodb_table.resume_data
  id = "CHONGYL_RESUME_DATA"
}

import {
  to = aws_apigatewayv2_api.api_gateway
  id = "c1ohm28wsg"
}

import {
  to = aws_apigatewayv2_route.api_route
  id = "c1ohm28wsg/7ga0wd6"
}

import {
  to = aws_apigatewayv2_integration.api_integration
  id = "c1ohm28wsg/gfzof9f"
}

import {
  to = aws_apigatewayv2_stage.api_stage
  id = "c1ohm28wsg/$default"
}

import {
  to = aws_iam_role.lambda_role
  id = "lambda-apigateway-role"
}

import {
  to = aws_iam_policy.lambda_policy
  id = "arn:aws:iam::144421025322:policy/lambda-apigateway-policy"
}

import {
  to = aws_iam_role_policy_attachment.attachment
  id = "lambda-apigateway-role/arn:aws:iam::144421025322:policy/lambda-apigateway-policy"
}

import {
  to = aws_lambda_function.lambda
  id = "updateVisitorCount"
}

import {
  to = aws_cloudwatch_log_group.lambda_log_group
  id = "/aws/lambda/updateVisitorCount"
}

import {
  to = aws_lambda_permission.lambda_permission
  id = "updateVisitorCount/c22b4a28-1a53-5687-83f4-5c97abf8c261"
}