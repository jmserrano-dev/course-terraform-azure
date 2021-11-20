# Crear un grupo de recursos que contenga una cuenta de almacenamiento con un contenedor y una carpeta compartida
# Todo debe tener dependencia implícita
# Parametrizar etiquetas, el tier de acceso de los blobs y el uso del HTTPs oblogatorio



resource "azurerm_resource_group" "rg" {
  name     = "rgexercise2"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage" {
  name                      = "storage"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = var.tier
  account_replication_type  = "LRS"
  enable_https_traffic_only = var.https
  tags                      = var.tags
}

resource "azurerm_storage_container" "container" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}


resource "azurerm_storage_share" "file" {
  name                 = "file"
  quota                = 50
  storage_account_name = azurerm_storage_account.storage.name
}
