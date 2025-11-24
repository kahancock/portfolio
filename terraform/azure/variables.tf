variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-portfolio-prod"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "static_web_app_name" {
  description = "Name of the Azure Static Web App"
  type        = string
  default     = "swa-portfolio-prod"
}

variable "custom_domain" {
  description = "Custom domain for the Static Web App"
  type        = string
  default     = "azure.kylehancock.com"
}
