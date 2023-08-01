######################################################################################
####                         POSTGRESQL FLEXIBLE SERVER                           ####
######################################################################################


resource "azurerm_subnet" "example1" {
  count                = var.create_postgresql_fs ? 1 : 0  
  name                 = var.subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints
  delegation {
    name = var.delegation_name
    service_delegation {
      name    = var.service_delegation_name_postgresql_fs
      actions = var.service_delegation_action_postgresql_fs
    }
  }
}

resource "azurerm_private_dns_zone" "example" {
  count               = var.create_postgresql_fs ? 1 : 0  
  name                = var.private_dns_zone_postgresql_fs_name
  resource_group_name = var.resource_group

  tags = {
     environment = var.environment
     name        = "${var.project}-${var.environment}-${var.private_dns_zone_postgresql_fs_name}"
}
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  count                 = var.create_postgresql_fs ? 1 : 0  
  name                  = var.dns_zone_virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.example[0].name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group
  tags = {
      environment = var.environment
      name        = "${var.project}-${var.environment}-${var.dns_zone_virtual_network_link_name}"
  }
}


resource "azurerm_postgresql_flexible_server" "example1" {
  count                  = var.create_postgresql_fs ? 1 : 0
  name                   = var.fs_server_name
  resource_group_name    = var.resource_group
  location               = var.location
  version                = var.fs_server_version
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  storage_mb             = var.fs_storage_mb
  sku_name               = var.fs_sku_name
  backup_retention_days  = var.backup_retention_days
  create_mode                   = var.create_mode
    high_availability {
          mode = var.high_availability_mode
     }

  delegated_subnet_id    = azurerm_subnet.example1[count.index].id
  private_dns_zone_id    = azurerm_private_dns_zone.example[count.index].id
  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]

  tags = {
    environment = var.environment
    name        = "${var.project}-${var.environment}-${var.fs_server_name}"
  }
}

resource "azurerm_postgresql_flexible_server_database" "dbs" {
  count        = var.create_postgresql_fs ? 1 : 0
  name         = var.fs_db_names
  server_id    = azurerm_postgresql_flexible_server.example1[0].id
  collation    = var.fs_db_collation
  charset      = var.fs_db_charset
}