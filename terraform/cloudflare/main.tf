terraform {
  required_version = ">= 1.6"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  # Backend config is supplied at init time via -backend-config flag.
  # See .github/workflows/cloudflare-deploy.yml for the full configuration.
  # Required vars: CF_TF_STATE_BUCKET, CLOUDFLARE_ACCOUNT_ID
  # Required secrets: CF_R2_ACCESS_KEY_ID, CF_R2_SECRET_ACCESS_KEY
  backend "s3" {
    skip_requesting_account_id = true
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
