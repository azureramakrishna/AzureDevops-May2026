# Datasource variables
# resource_group_name  = "terraform-deployment-rg"
# virtual_network_name = "terraform-vnet"
# subnet_name          = "default"
# keyvault_name        = "saanvikitkv003"

# Resources variables
resource_group_name  = "terraform-multiresource-rg"
location             = "eastus"
storage_account_name = "saanvikit2026"
count_value          = 30
tags = {
  "Project"     = "SAANVIKIT"
  "Owner"       = "RK"
  "Environment" = "DEV"
}
# network_security_group_name = "terraform-nsg"
# public_ip_name              = "terraform-pip"
# network_interface_name      = "terraform-nic"
# virtual_machine_name        = "terraform-vm"
# virtual_machine_size        = "Standard_DS1_v2"