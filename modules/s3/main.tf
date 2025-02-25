resource "aws_s3_bucket" "static_website" {
  bucket = var.bucket_name
  tags   = merge(var.common_tags, { Name = "Static Website Bucket - ${var.environment}" })
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket                  = aws_s3_bucket.static_website.id
  block_public_acls       = false
  block_public_policy     = false # Allow public policies
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_website" {
  bucket = aws_s3_bucket.static_website.id
  policy = data.aws_iam_policy_document.static_website.json
}

data "aws_iam_policy_document" "static_website" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.static_website.arn}/*",
    ]
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_website.bucket
  key          = "index.html"
  source       = "${path.module}/../../src/index.html" # Adjusted path
  content_type = "text/html"
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.static_website.bucket
  key          = "error.html"
  source       = "${path.module}/../../src/error.html" # Adjusted path
  content_type = "text/html"
}