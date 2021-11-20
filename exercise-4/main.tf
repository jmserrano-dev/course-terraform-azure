# Crear un grupo de recursos que contenga:
# * Una red virtual con una máquina virtual asociada que tenga un disco adicional de 125GB
#   y con el diagnostico habilitado hacua una cuenta de almacenamiento que creemos.
# * La tarjeta de red de la máquina virtual debe tener:
#   - Una IP pribada estática y una IP pública dinámica
#   - Un NSG asociado de una regla de RDP o SSH a la IP pública
# * El nombre del grupo de recursos y los recursos se tiene que obtener desde una variable común, y
#   y a los recursos se les tiene que añadir sufijo -vnet, -nsg, -nic, etc. excepto a la máquina virtual y recuross que funcionene con URL
# * SE debe parametrizar el tamaño de la máquina virtual, la contraseña y la asignación de direccionamiento de la IP pública
# * El nombre de la cuenta de almacenamiento se debe obtener de la salida del nombre del grupo de recursos forzando las letras en minúscula
# * Los nombres de los discos de la máquina virtual no debe tener un hash y su nombre debe ser el mismo que la máquina virtual añadiéndoles el sufijo -osdisk y -datadisk
# * Se debe obtener como salida la cadena de conexión de la cuenta de almacenamiento

resource "azurerm_resource_group" "rg" {
  name     = "rgexercise4"
  location = "West Europe"
}
