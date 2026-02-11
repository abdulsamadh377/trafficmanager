variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  default = "Password@123456"   # change in real projects
}
locals {
  common_tags = {
    environment = "dev"
    owner       = "terraform"
    project     = "traffic-manager-demo"
  }
}
