locals {
  name = "ep6"
}

resource "azurerm_public_ip" "vpn" {
  name                = "vpn-pip"
  location            = var.rg.location
  resource_group_name = var.rg.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpn" {
  name                = "vnet-getway"
  location            = var.rg.location
  resource_group_name = var.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway.id
  }

  vpn_client_configuration {
    address_space        = ["10.2.0.0/24"]
    vpn_auth_types       = ["AAD"]
    aad_tenant           = "https://login.microsoftonline.com/d4883360-2ffb-43df-ae0e-8a26b3c6d427/"
    aad_audience         = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
    aad_issuer           = "https://sts.windows.net/d4883360-2ffb-43df-ae0e-8a26b3c6d427/"
    vpn_client_protocols = ["OpenVPN"]
  }

}