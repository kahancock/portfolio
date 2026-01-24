variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region for resources"
  type        = string
  default     = "us-central1"
}

variable "domain" {
  description = "Domain name for SSL certificate and DNS"
  type        = string
}

variable "service_account_email" {
  description = "Service account email for Terraform state access"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name (production, staging, etc)"
  type        = string
  default     = "production"
}
