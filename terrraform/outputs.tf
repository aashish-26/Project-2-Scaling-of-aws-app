output "alb_dns" {
  value = module.alb.alb_dns_name
}

output "cloudfront_url" {
  value = module.s3_cloudfront.cloudfront_domain
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "redis_endpoint" {
  value = module.redis.redis_endpoint
}
