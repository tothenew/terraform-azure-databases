resource "azurerm_private_endpoint" "private_endpoint" {
  count               = var.create_mariadb ? 1 : 0
  name                = format("%s-private-endpoint", var.server-name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.db_subnet[count.index].id

  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))

  private_service_connection {
    name                           = var.private_service_connection_name
    is_manual_connection           = var.private_service_connection_is_manual_connection
    private_connection_resource_id = azurerm_mariadb_server.mariadb_server[count.index].id
    subresource_names              = var.private_service_connection_subresource_names
  }
}

resource "azurerm_mariadb_server" "mariadb_server" {
  count               = var.create_mariadb ? 1 : 0
  name                = var.server-name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password

  sku_name   = var.mariadb_sku
  storage_mb = var.mariadb_storage_mb
  version    = var.mariadb_version

  auto_grow_enabled                = var.auto_grow_enabled
  backup_retention_days            = var.backup_retention_days
  geo_redundant_backup_enabled     = var.mariadb_geo_redundant_backup_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced

  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "azurerm_mariadb_database" "mariadb_database" {
  count               = var.create_mariadb ? 1 : 0
  name                = var.db-name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mariadb_server.mariadb_server[0].name
  charset             = var.databases_charset
  collation           = var.databases_collation
}