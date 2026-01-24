terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "gcp-kylehancock-com-terraform-state"
    prefix = "portfolio/gcp"
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Cloud Storage bucket for hosting
resource "google_storage_bucket" "portfolio_bucket" {
  name     = "${lower(var.gcp_project_id)}-portfolio-bucket"
  location = var.gcp_region

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }

  versioning {
    enabled = true
  }
}

# Make bucket public for static hosting
resource "google_storage_bucket_iam_member" "public_read" {
  bucket = google_storage_bucket.portfolio_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Cloud CDN backend bucket
resource "google_compute_backend_bucket" "portfolio_backend" {
  name                 = "portfolio-backend-bucket"
  bucket_name          = google_storage_bucket.portfolio_bucket.name
  enable_cdn           = true
  compression_mode     = "AUTOMATIC"
  edge_security_policy = google_compute_security_policy.portfolio_policy.id

  cdn_policy {
    cache_mode       = "CACHE_ALL_STATIC"
    default_ttl      = 3600
    max_ttl          = 86400
    negative_caching = true
    negative_caching_policy {
      code = 404
      ttl  = 120
    }
    negative_caching_policy {
      code = 410
      ttl  = 120
    }
    serve_while_stale = 86400
  }
}

# Cloud Armor edge security policy (required for backend buckets)
resource "google_compute_security_policy" "portfolio_policy" {
  name = "portfolio-security-policy"
  type = "CLOUD_ARMOR_EDGE"

  # Allow all by default
  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default allow rule"
  }
}

# HTTP(S) Load Balancer - URL map
resource "google_compute_url_map" "portfolio_lb" {
  name            = "portfolio-load-balancer"
  default_service = google_compute_backend_bucket.portfolio_backend.id
}

# HTTPS Proxy
resource "google_compute_target_https_proxy" "portfolio_https" {
  name             = "portfolio-https-proxy"
  url_map          = google_compute_url_map.portfolio_lb.id
  ssl_certificates = [google_compute_managed_ssl_certificate.portfolio_cert.id]
}

# HTTP to HTTPS redirect proxy
resource "google_compute_target_http_proxy" "portfolio_http" {
  name    = "portfolio-http-proxy"
  url_map = google_compute_url_map.portfolio_redirect.id
}

# HTTP redirect URL map
resource "google_compute_url_map" "portfolio_redirect" {
  name = "portfolio-http-redirect"

  default_url_redirect {
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    https_redirect         = true
    strip_query            = false
  }
}

# Global forwarding rule for HTTPS
resource "google_compute_global_forwarding_rule" "portfolio_https" {
  name                  = "portfolio-https-forwarding-rule"
  target                = google_compute_target_https_proxy.portfolio_https.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  ip_version            = "IPV4"
}

# Global forwarding rule for HTTP
resource "google_compute_global_forwarding_rule" "portfolio_http" {
  name                  = "portfolio-http-forwarding-rule"
  target                = google_compute_target_http_proxy.portfolio_http.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  ip_version            = "IPV4"
}

# Managed SSL Certificate
resource "google_compute_managed_ssl_certificate" "portfolio_cert" {
  name = "portfolio-ssl-cert"

  managed {
    domains = [var.domain]
  }

  lifecycle {
    create_before_destroy = true
  }
}
