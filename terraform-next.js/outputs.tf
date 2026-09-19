
output "nextjs_bucket_website" {
  value = aws_s3_bucket_website_configuration.nextjs_bucket_website.website_endpoint
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.nextjs_distribution.domain_name
}
