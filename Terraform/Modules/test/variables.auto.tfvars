resource_group_name  = "test-resource-group"
location             = "uksouth"
storage_account_name = "testsaanvikitsa"
tags = {
  environment = "test"
  project     = "terraform-azure"
}
virtual_network_name        = "test-vnet"
virtual_network_address     = ["172.16.0.0/24"]
subnet_name                 = "test-subnet"
subnet_address              = ["172.16.0.0/24"]
network_security_group_name = "test-nsg"
pip_name                    = "test-pip"
network_interface_name      = "test-nic"
virtual_machine_name        = "test-vm"
virtual_machine_size        = "Standard_D2s_v3" // 2 vCPU, 8 GB RAM
admin_user                  = "azureuser"
admin_password              = "P@ssw0rd1234!"