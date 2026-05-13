# Terraform backend configuration for Azure Storage Account
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "terraformstatesa758"
    container_name       = "tfstate"
    key                  = "foreach.terraform.tfstate"
  }
}