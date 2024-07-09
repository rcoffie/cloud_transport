output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "win-vm-subnet" {
  value = azurerm_subnet.win-vm-subnet
}

output "gateway" {
  value = azurerm_subnet.gateway
}