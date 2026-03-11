variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "project_name" {
  description = "Cloudflare Pages project name"
  type        = string
  default     = "portfolio"
}

variable "custom_domain" {
  description = "Custom domain for the Pages project, e.g., cloudflare.kylehancock.com"
  type        = string
  default     = "cloudflare.kylehancock.com"
}
