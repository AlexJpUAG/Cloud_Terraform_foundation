resource "aws_s3_bucket" "photo_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "Photo Upload Bucket"
  }
}

# Optional: enable public access block (recommended)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.photo_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
