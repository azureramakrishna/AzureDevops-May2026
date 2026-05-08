variable "resource_group_name" {
  type = string
  default = "saanvikit-tf-rg"
  description = "Name of the resource group"
}

variable "location" {
  type = string
  default = "centralindia"
  description = "Location of the resource group"
}


variable "storage_account_name" {
  type    = string
  default = "saanvikit202605"
}

variable "tags" {
  type = map(string)
  default = {
    "Project"     = "SAANVIKIT"
    "Owner"       = "RK"
    "Environment" = "DEV"
  }
}