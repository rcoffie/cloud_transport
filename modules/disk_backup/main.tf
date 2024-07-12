resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = "tfex-recovery-vault"
  location            = var.rg.location
  resource_group_name = var.rg.name
  sku                 = "Standard"
}

resource "azurerm_backup_policy_vm" "backup_policy_vm" {
  name                = "tfex-recovery-vault-policy"
  resource_group_name = var.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_vault.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }
  retention_daily {
    count = 10
  }
}



resource "azurerm_backup_protected_vm" "vm1" {
  resource_group_name = var.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_vault.name
  source_vm_id        = var.vm.id
  backup_policy_id    = azurerm_backup_policy_vm.backup_policy_vm.id
}