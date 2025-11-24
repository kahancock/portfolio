# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.0"
    }
  }

  backend "azurerm" {
    # Backend configuration will be provided via command line
  }
}

# Configure the Azure Resource Manager Provider
provider "azurerm" {
  features {}
}

provider "azuread" {
}

# Data source for current Azure client configuration
data "azurerm_client_config" "current" {}

# Create a resource group
resource "azurerm_resource_group" "portfolio" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Production"
    Project     = "Portfolio"
  }
}

# Create a Static Web App
resource "azurerm_static_web_app" "portfolio" {
  name                = var.static_web_app_name
  resource_group_name = azurerm_resource_group.portfolio.name
  location            = azurerm_resource_group.portfolio.location
  sku_tier            = "Free"
  sku_size            = "Free"

  tags = {
    Environment = "Production"
    Project     = "Portfolio"
  }
}

# Create a custom domain for the Static Web App
resource "azurerm_static_web_app_custom_domain" "portfolio" {
  static_web_app_id = azurerm_static_web_app.portfolio.id
  domain_name       = var.custom_domain
  validation_type   = "cname-delegation"

  depends_on = [azurerm_static_web_app.portfolio]
}
