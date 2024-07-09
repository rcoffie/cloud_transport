# Virtual WAN
resource "azurerm_virtual_wan" "vwan" {
  name                = "${var.prefix}-vwan"
  resource_group_name = var.rg.name
  location            = var.rg.location
}