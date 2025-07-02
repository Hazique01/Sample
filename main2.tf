# AWS provider
provider "aws" {
  region = "us-east-1"
}

# Misconfigured public S3 bucket (AWS)
resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-unique-bucket-name-12345"
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.test_bucket.id
  acl    = "public-read" # UNSAFE: Public access enabled
}

# GCP provider
provider "google" {
  project = "my-gcp-project"
  region  = "us-central1"
}

# GCP: Misconfigured Google Storage Bucket (world readable)
resource "google_storage_bucket" "bad_bucket" {
  name     = "my-unique-gcp-bucket-12345"
  location = "US"
  uniform_bucket_level_access = false
}

resource "google_storage_bucket_iam_binding" "public_rule" {
  bucket = google_storage_bucket.bad_bucket.name
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers", # UNSAFE: Public access enabled
  ]
}
