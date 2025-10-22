# IAM Role for EC2 instance
resource "aws_iam_role" "ec2_role" {
  name = "photo-upload-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy to allow S3 actions
resource "aws_iam_policy" "s3_policy" {
  name        = "ec2-s3-upload-policy"
  description = "Allow EC2 to upload to S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.photo_bucket.arn,
          "${aws_s3_bucket.photo_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# Instance profile (EC2 needs this to assume the role)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "photo-upload-ec2-profile"
  role = aws_iam_role.ec2_role.name
}
