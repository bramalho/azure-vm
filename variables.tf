variable "prefix" {
  type    = string
  default = "test"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "environment" {
  type    = string
  default = "test"
}

variable "admin_username" {
  type    = string
  default = "app"
}

variable "admin_password" {
  type    = string
  default = "pass123!"
}

variable "ssh_key" {
  type    = string
  default  = "~/.ssh/id_rsa.pub"
}
