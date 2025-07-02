# main.tf
provider "aws" {
  region = "us-east-1"
}

# Misconfigured public S3 bucket
resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-unique-bucket-name-12345" # Change to unique name
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.test_bucket.id
  acl    = "public-read" # UNSAFE: Public access enabled
}

# Overly permissive IAM policy
resource "aws_iam_policy" "test_policy" {
  name        = "test_policy"
  description = "Overly permissive test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*" # UNSAFE: Wildcard action
        Resource = "*" # UNSAFE: Wildcard resource
      }
    ]
  })
}
