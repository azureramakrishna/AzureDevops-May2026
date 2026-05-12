variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "keyvault_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "network_security_group_name" {
  type = string
}

variable "public_ip_name" {
  type = string
}

variable "network_interface_name" {
  type = string
}

variable "virtual_machine_name" {
  type = string
}

variable "virtual_machine_size" {
  type = string
}