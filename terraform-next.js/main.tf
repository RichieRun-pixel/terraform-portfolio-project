provider "aws" {
  region = "eu-west-2"
}

# s3 bucket
resource "aws_s3_bucket" "nextjs_bucket" {
  bucket = "nextjs-portfolio-richard-2026"

  tags = {
    Name        = "Next.js Portfolio"
    Environment = "production"
  }
}

resource "aws_s3_bucket_website_configuration" "nextjs_bucket_website" {
  bucket = aws_s3_bucket.nextjs_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}




# bucket policy 
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.nextjs_bucket.id


    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.nextjs_bucket.arn}/*"
      }
    ]
  })
}
# cloudfront distribution

resource "aws_cloudfront_distribution" "nextjs_distribution" {
  origin { 
    domain_name = aws_s3_bucket.nextjs_bucket.bucket_regional_domain_name
    origin_id   = "S3-nextjs-portfolio-richard-2026"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  } 

  enabled            = true
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-nextjs-portfolio-richard-2026"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

}

viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "Portfolio Cloudfront"
    Environment = "production"
  }
}
  