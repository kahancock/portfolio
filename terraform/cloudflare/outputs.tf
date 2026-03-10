output "pages_project_name" {
  description = "Name of the Cloudflare Pages project"
  value       = cloudflare_pages_project.portfolio.name
}

output "pages_subdomain" {
  description = "Default Pages subdomain (*.pages.dev)"
  value       = "${cloudflare_pages_project.portfolio.name}.pages.dev"
}

output "custom_domain" {
  description = "Custom domain configured for the Pages project"
  value       = cloudflare_pages_domain.portfolio.domain
}

output "site_url" {
  description = "Website URL"
  value       = "https://${var.custom_domain}"
}

output "dns_cname_target" {
  description = "CNAME target to configure in your external DNS provider"
  value       = "${cloudflare_pages_project.portfolio.name}.pages.dev"
}
