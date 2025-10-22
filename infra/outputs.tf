output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.photo_app.public_ip
}

output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.photo_bucket.bucket
}

output "instance_role" {
  description = "IAM Role assigned to EC2"
  value       = aws_iam_role.ec2_role.name
}
