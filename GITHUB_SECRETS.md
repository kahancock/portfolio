# GitHub Secrets Setup Guide

This document lists all the GitHub repository secrets required for AWS S3 + CloudFront deployment.

## Required Secrets

Navigate to your repository → Settings → Secrets and variables → Actions, then add these secrets:

### AWS Credentials
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```
- Create an IAM user with programmatic access
- Attach policies: PowerUserAccess (or more restrictive custom policy for S3, CloudFront, Route53, ACM)
- Generate access keys and add them as secrets

### Domain Configuration
```
DOMAIN=kylehancock.com
AWS_FQDN=www.kylehancock.com
```
- Your apex domain (must have a Route53 hosted zone)
- Your full domain where the site will be served

### Terraform State Backend (Create using bootstrap/)
```
TF_STATE_BUCKET=portfolio-terraform-state-xxxxxxxx
TF_STATE_LOCK_TABLE=portfolio-terraform-locks
```
- Run the bootstrap configuration first to create these resources
- Add the output values as GitHub secrets

## Setup Order

1. **AWS Credentials**: Set up IAM user and add AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY
2. **Bootstrap**: Run `terraform apply` in the `aws/bootstrap/` directory
3. **Terraform Secrets**: Add TF_STATE_BUCKET and TF_STATE_LOCK_TABLE from bootstrap output
4. **Domain Secrets**: Add DOMAIN and AWS_FQDN

## Verification

After setup, your GitHub repository should have 5 secrets:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY  
- DOMAIN
- AWS_FQDN
- TF_STATE_BUCKET
- TF_STATE_LOCK_TABLE

## Required AWS Permissions

Your IAM user needs permissions for:
- S3 (bucket creation, object management)
- CloudFront (distribution management)
- Route53 (DNS record management)
- ACM (certificate management)
- DynamoDB (for Terraform state locking)

Example minimal policy:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*",
        "cloudfront:*",
        "route53:*",
        "acm:*",
        "dynamodb:*"
      ],
      "Resource": "*"
    }
  ]
}
```
