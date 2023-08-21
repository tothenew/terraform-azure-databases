resource "azurerm_private_dns_zone" "private_dns_zone" {
  count               = var.create_postgresql_fs ? 1 : 0  
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name

   tags               = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  count                 = var.create_postgresql_fs ? 1 : 0  
  name                  = var.dns_zone_virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[0].name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  resource_group_name   = var.resource_group_name

   tags                 = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}