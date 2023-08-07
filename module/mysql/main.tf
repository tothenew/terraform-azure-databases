######################################################################################
####                         MYSQL FLEXIBLE SERVER                                ####
######################################################################################

resource "azurerm_subnet" "mysql_db_subnet" {
  count                = var.create_mysql_fs ? 1 : 0
  name                 = var.subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints
  delegation {
    name = var.delegation_name
    service_delegation {
      name   = var.service_delegation_name_mysql_fs
      actions = var.service_delegation_action_mysql_fs
    }
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  count               = var.create_mysql_fs ? 1 : 0
  name                = var.private_dns_zone_mysql_fs_name
  resource_group_name = var.resource_group

  tags = merge(var.default_tags, var.common_tags , {
    "Name"        = "${var.name_prefix}",
  })
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  count                 = var.create_mysql_fs ? 1 : 0
  name                  = var.dns_zone_virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[0].name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group

  tags = merge(var.default_tags, var.common_tags , {
    "Name"        = "${var.name_prefix}",
  })
}

resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  count                  = var.create_mysql_fs ? 1 : 0
  name                   = var.mysql_fs_server_name
  resource_group_name    = var.resource_group
  location               = var.location
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  sku_name               = var.mysql_sku_name
  backup_retention_days  = var.backup_retention_days 
  create_mode            = var.create_mode


  delegated_subnet_id    = azurerm_subnet.mysql_db_subnet[count.index].id
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns_zone[count.index].id

 depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_vnet_link]

  storage {
    auto_grow_enabled            = var.auto_grow_enabled
    iops                         = var.iops
    size_gb                      = var.storagesize_gb
  }
    geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
    zone                         = var.zone
    
  tags = merge(var.default_tags, var.common_tags , {
    "Name"        = "${var.name_prefix}",
  })
}

resource "azurerm_mysql_flexible_database" "mysql_database" {
  count               = var.create_mysql_fs ? 1 : 0
  name                = var.db_names
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server[count.index].name
  charset             = var.mysql_fs_db_charset
  collation           = var.mysql_fs_db_collation
}

