resource "azurerm_private_endpoint" "private_endpoint" {
  count               = var.create_mariadb ? 1 : 0
  name                = format("%s-private-endpoint", var.server-name)
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = var.subnet_id
  
  tags                 = var.tags

  private_service_connection {
    name                           = var.private_service_connection_name
    is_manual_connection           = var.private_service_connection_is_manual_connection
    private_connection_resource_id = azurerm_mariadb_server.mariadb_server[count.index].id
    subresource_names              = var.private_service_connection_subresource_names
  }
}

resource "azurerm_mariadb_server" "mariadb_server" {
  count                            = var.create_mariadb ? 1 : 0
  name                             = var.server-name
  location                         = var.location
  resource_group_name              = var.resource_group

  administrator_login              = var.administrator_login
  administrator_login_password     = var.administrator_password

  sku_name                         = var.mariadb_sku
  storage_mb                       = var.mariadb_storage_mb
  version                          = var.mariadb_version

  auto_grow_enabled                = var.auto_grow_enabled
  backup_retention_days            = var.backup_retention_days
  geo_redundant_backup_enabled     = var.mariadb_geo_redundant_backup_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced

  tags                 = var.tags
}

resource "azurerm_private_dns_zone" "mariadb_private_dns_zone" {
  count               = var.create_mariadb ? 1 : 0
  name                = var.mariadb_private_dns_zone_name
  resource_group_name = var.resource_group

  tags                 = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "mariadb_dns_zone_virtual_network_link" {
  count                 = var.create_mariadb ? 1 : 0
  name                  = var.dns_zone_virtual_network_link_name
  resource_group_name   = var.resource_group
  private_dns_zone_name = azurerm_private_dns_zone.mariadb_private_dns_zone.0.name
  virtual_network_id    = var.vnet_id

  tags                  = var.tags
}


resource "azurerm_mariadb_database" "mariadb_database" {
  count               = var.create_mariadb ? 1 : 0
  name                = var.db-name
  resource_group_name = var.resource_group
  server_name         = azurerm_mariadb_server.mariadb_server[0].name
  charset             = var.databases_charset
  collation           = var.databases_collation
}