# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}


# # Create a virtual network within the resource group
# resource "azurerm_virtual_network" "example" {
#   name                = "example-network"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   address_space       = ["10.0.0.0/16"]
# }


module "rg" {
  source = "./modules/rg"
}

module "vnet" {
  source = "./modules/vnet"
  rg     = module.rg.rg
}

module "win-vm" {
  source        = "./modules/win-vm"
  rg            = module.rg.rg
  win-vm-subnet = module.vnet.win-vm-subnet
}

module "vpn" {
  source  = "./modules/vpn"
  rg      = module.rg.rg
  gateway = module.vnet.gateway
}

# module "disk_backup" {
#   source       = "./modules/disk_backup"
#   rg           = module.rg.rg
#   managed_disk = module.win-vm.managed_disk
#   snapshot-rg  = module.rg.snapshot-rg
#   vm           = module.win-vm.vm
# }

module "alert_policy" {
  source = "./modules/alert_policy"
  rg     = module.rg.rg
  vm     = module.win-vm.vm
}