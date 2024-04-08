######################################################################################
####                         POSTGRESQL FLEXIBLE SERVER                           ####
######################################################################################

resource "azurerm_postgresql_flexible_server" "prostgres_flexible_server" {
  count                  = var.create_postgresql_fs ? 1 : 0
  name                   = var.fs_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.fs_server_version
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  storage_mb             = var.fs_storage_mb
  sku_name               = var.fs_sku_name
  backup_retention_days  = var.backup_retention_days
  create_mode            = var.create_mode

  high_availability {
    mode = var.high_availability_mode
  }

  delegated_subnet_id = data.azurerm_subnet.db_subnet.id
  private_dns_zone_id = azurerm_private_dns_zone.private_dns_zone.0.id
  depends_on          = [azurerm_private_dns_zone_virtual_network_link.dns_vnet_link]

  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "azurerm_postgresql_flexible_server_database" "postgres_database" {
  count     = var.create_postgresql_fs ? 1 : 0
  name      = var.fs_db_names
  server_id = azurerm_postgresql_flexible_server.prostgres_flexible_server[0].id
  collation = var.fs_db_collation
  charset   = var.fs_db_charset
}