output "storage_bucket_name" {
  description = "Name of the Cloud Storage bucket"
  value       = google_storage_bucket.portfolio_bucket.name
}

output "storage_bucket_url" {
  description = "URL of the Cloud Storage bucket"
  value       = "gs://${google_storage_bucket.portfolio_bucket.name}"
}

output "load_balancer_ip" {
  description = "External IP address of the load balancer"
  value       = google_compute_global_forwarding_rule.portfolio_https.ip_address
}

output "load_balancer_name" {
  description = "Name of the load balancer"
  value       = google_compute_url_map.portfolio_lb.name
}

output "cdn_backend_name" {
  description = "Name of the Cloud CDN backend"
  value       = google_compute_backend_bucket.portfolio_backend.name
}

output "security_policy_name" {
  description = "Name of the Cloud Armor security policy"
  value       = google_compute_security_policy.portfolio_policy.name
}

output "ssl_certificate_name" {
  description = "Name of the managed SSL certificate"
  value       = google_compute_managed_ssl_certificate.portfolio_cert.name
}
