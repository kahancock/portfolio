# This file should be run ONCE to set up the S3 bucket and DynamoDB table
# for Terraform state management. Run this in a separate directory first.

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "project_name" {
  type        = string
  default     = "kh-portfolio"
  description = "Project name used for resource naming"
}

# S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${var.project_name}-terraform-state-${random_string.bucket_suffix.result}"
  force_destroy = false
  
  tags = {
    Name        = "Terraform State Bucket"
    Project     = var.project_name
    Environment = "shared"
  }
}

# Random string to make bucket name unique
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name           = "${var.project_name}-terraform-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Project     = var.project_name
    Environment = "shared"
  }
}

# Outputs
output "terraform_state_bucket" {
  value       = aws_s3_bucket.terraform_state.id
  description = "Name of the S3 bucket for Terraform state"
}

output "terraform_lock_table" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "Name of the DynamoDB table for Terraform state locking"
}

output "setup_instructions" {
  value = <<-EOT
    Terraform backend setup complete!
    
    Add these secrets to your GitHub repository:
    - TF_STATE_BUCKET: ${aws_s3_bucket.terraform_state.id}
    - TF_STATE_LOCK_TABLE: ${aws_dynamodb_table.terraform_locks.name}
  EOT
  description = "Instructions for setting up GitHub secrets"
}