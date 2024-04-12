
# The private_dns_zone_id is required when setting a delegated_subnet_id. The azurerm_private_dns_zone should end with suffix .mysql.database.azure.com. 
# for postgresql it should end with suffix .postgres.database.azure.com.

resource "azurerm_private_dns_zone" "private_dns_zone" {
  count               = var.is_public ? 0 : (var.create_mysql_fs || var.create_postgresql_fs) ? 1 : 0
  name                = var.create_mysql_fs ? var.private_dns_zone_name[0] : var.create_postgresql_fs ? var.private_dns_zone_name[1] : null
  resource_group_name = var.resource_group_name

  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  count                 = var.is_public ? 0 : (var.create_mysql_fs || var.create_postgresql_fs) ? 1 : 0
  name                  = var.dns_zone_virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.0.name
  virtual_network_id    = data.azurerm_virtual_network.vnet[count.index].id
  resource_group_name   = var.resource_group_name

  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

# resource "azurerm_private_dns_zone" "private_dns_zone" {
#   count               = var.is_public ? 0 : (var.create_mysql_fs || var.create_postgresql_fs) ? 1 : 0
#   name                = var.create_mysql_fs ? var.private_dns_zone_name[0] : var.create_postgresql_fs ? var.private_dns_zone_name[1] : null
#   resource_group_name = var.resource_group_name

#   tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
#   count               = var.is_public ? 0 : (var.create_mysql_fs || var.create_postgresql_fs) ? 1 : 0
#   name                  = var.dns_zone_virtual_network_link_name
#   private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[0].name
#   virtual_network_id    = data.azurerm_virtual_network.vnet[0].id
#   resource_group_name   = var.resource_group_name

#   tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
# }
