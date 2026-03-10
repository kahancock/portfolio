terraform {
  required_version = ">= 1.6"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    # Uses Cloudflare R2 as S3-compatible backend
    # Configuration is provided via backend-config parameters and
    # environment variables in GitHub Actions
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
    region                      = "us-east-1"
  }
}

provider "cloudflare" {
  # Uses CLOUDFLARE_API_TOKEN environment variable
}

# Cloudflare Pages project for static site hosting
resource "cloudflare_pages_project" "portfolio" {
  account_id        = var.cloudflare_account_id
  name              = var.project_name
  production_branch = "main"

  build_config {
    build_command   = "npm run build"
    destination_dir = "dist"
  }
}

# Custom domain for the Pages project
resource "cloudflare_pages_domain" "portfolio" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.portfolio.name
  domain       = var.custom_domain
}

# DNS is managed externally — create a CNAME record in your DNS provider
# pointing var.custom_domain to <project_name>.pages.dev
