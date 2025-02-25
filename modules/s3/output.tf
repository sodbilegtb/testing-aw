output "s3_website_url" {
  value = aws_s3_bucket_website_configuration.static_website.website_endpoint
  description = "The S3 static website URL"
}