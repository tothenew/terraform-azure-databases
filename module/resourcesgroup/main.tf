resource "azurerm_resource_group" "database-rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    environment = var.environment
    name = "${var.project}-${var.environment}-${var.resource_group_name}"
  }
}