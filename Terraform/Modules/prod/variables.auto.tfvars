resource_group_name  = "prod-resource-group"
location             = "centralindia"
storage_account_name = "prodsaanvikitsa"
tags = {
  environment = "prod"
  project     = "terraform-azure"
}
virtual_network_name        = "prod-vnet"
virtual_network_address     = ["192.168.0.0/24"]
subnet_name                 = "prod-subnet"
subnet_address              = ["192.168.0.0/24"]
network_security_group_name = "prod-nsg"
pip_name                    = "prod-pip"
network_interface_name      = "prod-nic"
virtual_machine_name        = "prod-vm"
virtual_machine_size        = "Standard_D2s_v3" // 2 vCPU, 8 GB RAM
admin_user                  = "azureuser"
admin_password              = "P@ssw0rd1234!"