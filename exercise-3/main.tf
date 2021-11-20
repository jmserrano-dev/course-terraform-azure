# Crear un grupo de recursos con una red virtual que tenga conectada una tarjeta de red con una IP púplica estática
# Usando la salida del nombre del grupo de recursos, crear el resto de recursos añadiendo los sufijos -vnet, -nic, -ip
# Parametrizar la opción del SKU de la IP pública
# Obtener mediante una salida la dirección IP de la IP pública

resource "azurerm_resource_group" "rg" {
  name     = "rgexercise3"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${azurerm_resource_group.rg.name}vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${azurerm_resource_group.rg.name}subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "ip" {
  name                    = "${azurerm_resource_group.rg.name}ip"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
  sku                     = var.azurerm_public_ip_sku
}

resource "azurerm_network_interface" "nic" {
  name                = "${azurerm_resource_group.rg.name}nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${azurerm_resource_group.rg.name}ip"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.ip.ip_address
}
