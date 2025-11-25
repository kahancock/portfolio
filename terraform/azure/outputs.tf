output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.portfolio.name
}

output "static_web_app_name" {
  description = "Name of the created Static Web App"
  value       = azurerm_static_web_app.portfolio.name
}

output "static_web_app_url" {
  description = "Default URL of the Static Web App"
  value       = azurerm_static_web_app.portfolio.default_host_name
  sensitive   = false
}

output "static_web_app_api_key" {
  description = "API key for Static Web App deployment"
  value       = azurerm_static_web_app.portfolio.api_key
  sensitive   = true
}

output "custom_domain" {
  description = "Custom domain configured for the Static Web App"
  value       = azurerm_static_web_app_custom_domain.portfolio.domain_name
}

output "cname_record" {
  description = "CNAME record value for DNS configuration"
  value       = azurerm_static_web_app.portfolio.default_host_name
}
