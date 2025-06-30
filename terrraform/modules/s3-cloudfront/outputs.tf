output "s3_bucket_name" {
  value = aws_s3_bucket.static_site.id
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
