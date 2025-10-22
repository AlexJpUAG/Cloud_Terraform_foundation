# Root configuration entry point for the Photo Upload App

# Load provider configuration
# (defined in provider.tf)
terraform {
  required_version = ">= 1.6.0"
}

# AWS provider is configured in provider.tf
# Variables and defaults are in variables.tf
# Resources:
# - S3 bucket (s3.tf)
# - IAM roles/policies (iam.tf)
# - EC2 instance and security group (ec2.tf)
# Outputs are defined in outputs.tf
