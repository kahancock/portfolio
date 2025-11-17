variable "name" {
  type        = string
  default     = "portfolio"
  description = "Project name used for resource naming"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for resources"
}

variable "domain" {
  type        = string
  description = "Root domain name (must have Route53 hosted zone), e.g., kylehancock.com"
}

variable "fqdn" {
  type        = string
  description = "Full domain name where site will be served, e.g., www.kylehancock.com"
}
