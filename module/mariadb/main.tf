resource "azurerm_subnet" "internal" {
  count                                         = var.create_mariadb ? 1 : 0
  name                                          = var.subnet_name
  resource_group_name                           = var.resource_group
  virtual_network_name                          = var.vnet_name
  address_prefixes                              = var.address_prefixes
  private_endpoint_network_policies_enabled     = var.private_endpoint_network_policies_enabled
  
  }

resource "azurerm_private_endpoint" "pep1" {
  count               = var.create_mariadb ? 1 : 0
  name                = format("%s-private-endpoint", var.server-name)
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = azurerm_subnet.internal[count.index].id
  
  tags = {
    environment = var.environment
    name = "${var.project}-${var.environment}-${"%s-private-endpoint"}-${var.server-name}"
  }

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
  
  tags = {
    environment = var.environment
    name        = "${var.project}-${var.environment}-${var.server-name}"
  }
}

resource "azurerm_private_dns_zone" "dnszone1" {
  count               = var.create_mariadb ? 1 : 0
  name                = var.mariadb_private_dns_zone_name
  resource_group_name = var.resource_group
  tags = {
    environment = var.environment
    name        = "${var.project}-${var.environment}-${var.mariadb_private_dns_zone_name}"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vent-link1" {
  count                 = var.create_mariadb ? 1 : 0
  name                  = var.dns_zone_virtual_network_link_name
  resource_group_name   = var.resource_group
  private_dns_zone_name = azurerm_private_dns_zone.dnszone1.0.name
  virtual_network_id    = var.vnet_id
  tags = {
        environment = var.environment
        name        = "${var.project}-${var.environment}-${var.dns_zone_virtual_network_link_name}"
  }
}


resource "azurerm_mariadb_database" "example" {
  count               = var.create_mariadb ? 1 : 0
  name                = var.db-name
  resource_group_name = var.resource_group
  server_name         = azurerm_mariadb_server.mariadb_server[0].name
  charset             = var.databases_charset
  collation           = var.databases_collation
}