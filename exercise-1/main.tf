# Crear un group de recursos desde el portal y referenciarlo mediante data
# Crear un red virtual
# Crear una subred como recurso independiente (dependencia explicita)
# Crear una tarjeta de red (dependencia implicita)

data "azurerm_resource_group" "rg" {
  name = "rgexercise1"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = "vnet"
  resource_group_name  = "rgexercise1"
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
