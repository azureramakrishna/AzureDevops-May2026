# Azurerm terraform provider version
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
}

# Azure Terraform Provider Configuration
provider "azurerm" {
  features {}
  
  client_id       = null
  client_secret   = null
  tenant_id       = null
  subscription_id = null
}