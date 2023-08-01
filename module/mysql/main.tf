######################################################################################
####                         MYSQL FLEXIBLE SERVER                                ####
######################################################################################

resource "azurerm_subnet" "example" {
  count               = var.create_mysql_fs ? 1 : 0
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

resource "azurerm_private_dns_zone" "example" {
  count               = var.create_mysql_fs ? 1 : 0
  name                = var.private_dns_zone_mysql_fs_name
  resource_group_name = var.resource_group
  tags = {
      environment = var.environment
      name        = "${var.project}-${var.environment}-${var.private_dns_zone_mysql_fs_name}"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  count                 = var.create_mysql_fs ? 1 : 0
  name                  = var.dns_zone_virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.example[0].name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group
  tags = {
      environment = var.environment
      name        = "${var.project}-${var.environment}-${var.dns_zone_virtual_network_link_name}"
  }
}

resource "azurerm_mysql_flexible_server" "example" {
  count                  = var.create_mysql_fs ? 1 : 0
  name                   = var.mysql_fs_server_name
  resource_group_name    = var.resource_group
  location               = var.location
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  sku_name               = var.mysql_sku_name
  backup_retention_days  = var.backup_retention_days 
  create_mode            = var.create_mode


  delegated_subnet_id    = azurerm_subnet.example[count.index].id
  private_dns_zone_id    = azurerm_private_dns_zone.example[count.index].id

 depends_on = [azurerm_private_dns_zone_virtual_network_link.example]

  storage {
    auto_grow_enabled            = var.auto_grow_enabled
    iops                         = var.iops
    size_gb                      = var.storagesize_gb
  }
    geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
    zone                         = var.zone
    
    tags = {
        environment = var.environment
        name        = "${var.project}-${var.environment}-${var.mysql_fs_server_name}"
  }
}

resource "azurerm_mysql_flexible_database" "example" {
  count               = var.create_mysql_fs ? 1 : 0
  name                = var.db_names
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_flexible_server.example[count.index].name
  charset             = var.mysql_fs_db_charset
  collation           = var.mysql_fs_db_collation
}

resource "azurerm_mysql_flexible_server_firewall_rule" "example" {
  count               = var.create_mysql_fs ? 1 : 0
  name                = var.firewall_rule_name
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_flexible_server.example[0].name
  start_ip_address    = var.start_ip
  end_ip_address      = var.end_ip
}

resource "azurerm_mysql_flexible_server_configuration" "mysql" {
  count               = var.create_mysql_fs ? 1 : 0
  name                = var.server_configuration_name
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_flexible_server.example[0].name
  value               = var.value
}