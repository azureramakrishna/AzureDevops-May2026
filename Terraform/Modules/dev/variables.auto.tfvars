resource_group_name  = "dev-resource-group"
location             = "eastus"
storage_account_name = "devsaanvikitsa"
tags = {
  environment = "dev"
  project     = "terraform-azure"
}
virtual_network_name        = "dev-vnet"
virtual_network_address     = ["10.0.0.0/24"]
subnet_name                 = "dev-subnet"
subnet_address              = ["10.0.0.0/24"]
network_security_group_name = "dev-nsg"
pip_name                    = "dev-pip"
network_interface_name      = "dev-nic"
virtual_machine_name        = "dev-vm"
virtual_machine_size        = "Standard_D2s_v3" // 2 vCPU, 8 GB RAM
admin_user                  = "azureuser"
admin_password              = "P@ssw0rd1234!"