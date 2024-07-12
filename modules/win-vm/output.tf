output "managed_disk" {
  value = azurerm_managed_disk.managed-disk
}

output "vm" {
  value = azurerm_windows_virtual_machine.vm
}