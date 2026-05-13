# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Storage Account
resource "azurerm_storage_account" "sa" {
  for_each                 = toset(var.storage_account_name)
  name                     = each.value
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# Create a Public IP Address
resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = var.tags
}


# # Create a Network Security Group
# resource "azurerm_network_security_group" "nsg" {
#   name                = var.network_security_group_name
#   location            = data.azurerm_resource_group.example.location
#   resource_group_name = data.azurerm_resource_group.example.name

#   security_rule {
#     name                       = "RDP-Allow"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "3389"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   tags = var.tags
# }

# # Associate NSG with Subnet
# resource "azurerm_subnet_network_security_group_association" "snet_nsg_assoc" {
#   subnet_id                 = data.azurerm_subnet.example.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }



# # Create a Network Interface
# resource "azurerm_network_interface" "nic" {
#   name                = var.network_interface_name
#   location            = data.azurerm_resource_group.example.location
#   resource_group_name = data.azurerm_resource_group.example.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = data.azurerm_subnet.example.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip.id
#   }
# }

# # Create a Virtual Machine
# resource "azurerm_windows_virtual_machine" "vm" {
#   name                = var.virtual_machine_name
#   resource_group_name = data.azurerm_resource_group.example.name
#   location            = data.azurerm_resource_group.example.location
#   size                = var.virtual_machine_size
#   admin_username      = data.azurerm_key_vault_secret.user.value
#   admin_password      = data.azurerm_key_vault_secret.password.value
#   network_interface_ids = [
#     azurerm_network_interface.nic.id,
#   ]

#   os_disk {
#     name                 = "${var.virtual_machine_name}-osdisk"
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2025-Datacenter"
#     version   = "latest"
#   }
# }

# # Create a Managed Disk and attach it to the Virtual Machine
# resource "azurerm_managed_disk" "data_disk" {
#   name                 = "${var.virtual_machine_name}-datadisk1"
#   location             = data.azurerm_resource_group.example.location
#   resource_group_name  = data.azurerm_resource_group.example.name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = 10
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
#   managed_disk_id    = azurerm_managed_disk.data_disk.id
#   virtual_machine_id = azurerm_windows_virtual_machine.vm.id
#   lun                = "10"
#   caching            = "ReadWrite"
# }
