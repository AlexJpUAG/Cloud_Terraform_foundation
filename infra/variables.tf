variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  type        = string
  default     = "ami-0b967c22fe917319b"
}

variable "bucket_name" {
  description = "Name for the S3 bucket"
  type        = string
  default     = "photo-upload-bucket-Cloud_AJP"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "photo-upload-ec2"
}
