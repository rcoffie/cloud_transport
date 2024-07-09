# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.cloud-transport-rg
  location = var.eastus-location
}


resource "azurerm_resource_group" "snapshot-rg" {
  name     = var.snapshot_resource_group_name
  location = var.eastus-location
}


