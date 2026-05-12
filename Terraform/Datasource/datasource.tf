# Use this data source to access information about an existing Resource Group.
data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

# Use this data source to access information about an existing Virtual Network.
data "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.example.name
}

# Use this data source to access information about an existing Subnet within a Virtual Network.
data "azurerm_subnet" "example" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.example.name
  resource_group_name  = data.azurerm_resource_group.example.name
}

# Use this data source to access information about an existing Key Vault.
data "azurerm_key_vault" "example" {
  name                = var.keyvault_name
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_key_vault_secret" "user" {
  name         = "vm-username"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.example.id
}



