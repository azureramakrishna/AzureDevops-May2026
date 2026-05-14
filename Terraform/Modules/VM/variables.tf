variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "storage_account_name" {
  type    = string
}

variable "tags" {
  type = map(string)
}

variable "virtual_network_name" {
  type = string
}

variable "virtual_network_address" {
  type    = list(string)
}

variable "subnet_name" {
  type = string
}

variable "subnet_address" {
  type    = list(string)
}

variable "network_security_group_name" {
  type = string
}

variable "pip_name" {
  type = string
}

variable "network_interface_name" {
  type = string
}

variable "virtual_machine_name" {
  type = string
}

variable "virtual_machine_size" {
  type    = string
}

variable "admin_user" {
  type    = string
}

variable "admin_password" {
  type    = string
}