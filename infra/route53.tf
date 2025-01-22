resource "aws_route53_zone" "primary" {
    name = "chongyl.com"
}

resource "aws_route53_record" "domain" {
    name = "chongyl.com"
    zone_id = aws_route53_zone.primary.zone_id
    type = "A"

    alias {
      name = aws_cloudfront_distribution.domain_distribution.domain_name
      zone_id = aws_cloudfront_distribution.domain_distribution.hosted_zone_id
      evaluate_target_health = false
    }
}

resource "aws_route53_record" "subdomain" {
    name = "www.chongyl.com"
    zone_id = aws_route53_zone.primary.zone_id
    type = "A"

    alias {
      name = aws_cloudfront_distribution.subdomain_distribution.domain_name
      zone_id = aws_cloudfront_distribution.subdomain_distribution.hosted_zone_id
      evaluate_target_health = false
    }
}