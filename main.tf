# main.tf

# 1. Configuration du fournisseur Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 2. Définition du Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# 3. Définition du Storage Account
resource "azurerm_storage_account" "sa" {
  name                       = var.storage_account_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  account_tier               = "Standard"
  account_replication_type   = var.replication_type
  account_kind               = "StorageV2"
  min_tls_version            = "TLS1_2"
  https_traffic_only_enabled = true
}
