data "azurerm_public_ip" "data_pip" {
  name                = azurerm_public_ip.pip.name
  resource_group_name = azurerm_virtual_machine.vm.resource_group_name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.data_pip.ip_address
}

output "domain" {
  value = "http://${var.prefix}.${var.location}.cloudapp.azure.com"
}

output "user" {
  value = var.admin_username
}
