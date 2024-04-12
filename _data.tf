data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# data "azurerm_virtual_network" "vnet" {
#   count =  var.is_public ? 0 : 1 
#   name                = var.vnet_name
#   resource_group_name = data.azurerm_resource_group.rg.name
# }

# data "azurerm_subnet" "db_subnet" {
#   count =  var.is_public ? 0 :1 
#   name                 = var.subnet_name
#   virtual_network_name = data.azurerm_virtual_network.vnet[count.index].name
#   resource_group_name  = data.azurerm_resource_group.rg.name
# }

data "azurerm_virtual_network" "vnet" {
  count = var.is_public ? 0 : 1
  name                = var.vnet_name
  resource_group_name = var.is_public ? "" : data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "db_subnet" {
  count = var.is_public ? 0 : 1
  name                 = var.subnet_name
  virtual_network_name = var.is_public ? "" : data.azurerm_virtual_network.vnet[0].name
  resource_group_name  = var.is_public ? "" : data.azurerm_resource_group.rg.name
}

