module "dev_vm" {
  source = "../VM"

  resource_group_name         = var.resource_group_name
  location                    = var.location
  storage_account_name        = var.storage_account_name
  tags                        = var.tags
  virtual_network_name        = var.virtual_network_name
  virtual_network_address     = var.virtual_network_address
  subnet_name                 = var.subnet_name
  subnet_address              = var.subnet_address
  network_security_group_name = var.network_security_group_name
  pip_name                    = var.pip_name
  network_interface_name      = var.network_interface_name
  virtual_machine_name        = var.virtual_machine_name
  virtual_machine_size        = var.virtual_machine_size
  admin_user                  = var.admin_user
  admin_password              = var.admin_password
}