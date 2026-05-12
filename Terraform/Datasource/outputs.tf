output "virtual_network_id" {
  value = data.azurerm_virtual_network.example.id
}

output "subnet_id" {
  value = data.azurerm_subnet.example.id
}

output "vault_uri" {
  value = data.azurerm_key_vault.example.vault_uri
}