# Datasource variables
# resource_group_name  = "terraform-deployment-rg"
# virtual_network_name = "terraform-vnet"
# subnet_name          = "default"
# keyvault_name        = "saanvikitkv003"

# Resources variables
resource_group_name  = "terraform-foreach-rg"
location             = "eastus"
storage_account_name = ["ramakrishnasa1305", "shikasa1305", "dasunsa1305", "devendersa1305", "gurusa1305", "surendrasa1305"]
tags = {
  "Project"     = "SAANVIKIT"
  "Owner"       = "RK"
  "Environment" = "DEV"
}
public_ip_name              = "saanvikit-pip"
# network_security_group_name = "terraform-nsg"
# network_interface_name      = "terraform-nic"
# virtual_machine_name        = "terraform-vm"
# virtual_machine_size        = "Standard_DS1_v2"