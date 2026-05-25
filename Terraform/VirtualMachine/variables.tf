variable "resource_group_name" {
  type        = string
  default     = "github-tf-rg"
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "centralindia"
  description = "Location of the resource group"
}


variable "storage_account_name" {
  type    = string
  default = "githubsa202645"
}

variable "tags" {
  type = map(string)
  default = {
    "Project"     = "GITHUB"
    "Owner"       = "RK"
    "Environment" = "DEV"
  }
}

variable "virtual_network_address" {
  type    = list(string)
  default = ["192.168.0.0/24"]
}

variable "subnet_address" {
  type    = list(string)
  default = ["192.168.0.0/24"]
}

variable "virtual_machine_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "admin_user" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type = string
}