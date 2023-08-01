resource "azurerm_virtual_network" "vnet01" {
  name                = var.vnet-name
  resource_group_name = var.resource_group
  location            = var.location
  address_space       = [var.vnetcidr]
 
  tags = {
    environment = var.environment
    name        = "${var.project}-${var.environment}-${var.vnet-name}"
  }

}
