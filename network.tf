resource "azurerm_resource_group" "rg1" {
  name     = "rg-primary"
  location = "East US"
}

resource "azurerm_resource_group" "rg2" {
  name     = "rg-secondary"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-primary"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet-secondary"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.1.1.0/24"]
}