resource_group_name  = "remote-resource-group"
location             = "westus2"
storage_account_name = "remotesaanvikitsa"
tags = {
  environment = "remote"
  project     = "terraform-azure"
}
virtual_network_name        = "remote-vnet"
virtual_network_address     = ["10.0.1.0/24"]
subnet_name                 = "remote-subnet"
subnet_address              = ["10.0.1.0/24"]
network_security_group_name = "remote-nsg"
pip_name                    = "remote-pip"
network_interface_name      = "remote-nic"
virtual_machine_name        = "remote-vm"
virtual_machine_size        = "Standard_D2s_v3" // 2 vCPU, 8 GB RAM
admin_user                  = "azureuser"
admin_password              = "P@ssw0rd1234!"