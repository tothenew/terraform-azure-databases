output "vnet_name" {
  value = azurerm_virtual_network.vnet01.name
  description = "Name of the Virtual network"
}

# output "subnet_id" {
#   value = azurerm_subnet.subnet1
#   description = "Id of container subnet in the network "
# }

output "vnet_id" {
  value = azurerm_virtual_network.vnet01.id
  description = "Name of the Virtual network"
}
