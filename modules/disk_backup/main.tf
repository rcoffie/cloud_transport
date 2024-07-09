

# resource "azurerm_managed_disk" "example" {
#   name                 = "example-disk"
#   location             = azurerm_resource_group.example.location
#   resource_group_name  = azurerm_resource_group.example.name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = "1"
# }

resource "azurerm_data_protection_backup_vault" "backup_vault" {
  name                = "backup-vault"
  resource_group_name = var.rg.name
  location            = var.rg.location
  datastore_type      = "VaultStore"
  redundancy          = "LocallyRedundant"
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = var.rg.id
  role_definition_name = "Disk Snapshot Contributor"
  principal_id         = azurerm_data_protection_backup_vault.backup_vault.identity[0].principal_id
}

resource "azurerm_role_assignment" "role_assignment2" {
  scope                = var.managed_disk.id
  role_definition_name = "Disk Backup Reader"
  principal_id         = azurerm_data_protection_backup_vault.backup_vault.identity[0].principal_id
}


resource "azurerm_data_protection_backup_policy_disk" "backup_policy_disk" {
  name     = "backup-policy"
  vault_id = azurerm_data_protection_backup_vault.backup_vault.id

  backup_repeating_time_intervals = ["R/2021-05-19T06:33:16+00:00/PT4H"]
  default_retention_duration      = "P7D"
}



# resource "azurerm_data_protection_backup_instance_disk" "data_protection_instance_disk" {
#   name                         = "backup-instance"
#   location                     = azurerm_data_protection_backup_vault.backup_vault.location
#   vault_id                     = azurerm_data_protection_backup_vault.backup_vault.id
#   disk_id                      = var.managed_disk.id
#   snapshot_resource_group_name = var.snapshot-rg.name
#   backup_policy_id             = azurerm_data_protection_backup_policy_disk.backup_policy_disk.id
# }