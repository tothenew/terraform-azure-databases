######################################################################################
####                         MYSQL FLEXIBLE SERVER                                ####
######################################################################################

resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  count                  = var.create_mysql_fs ? 1 : 0
  name                   = var.mysql_fs_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  sku_name               = var.mysql_sku_name
  backup_retention_days  = var.backup_retention_days
  create_mode            = var.create_mode

  version                = var.mysql_fs_server_version


  delegated_subnet_id = var.is_public ? null : data.azurerm_subnet.db_subnet[0].id
  private_dns_zone_id = var.is_public ? null : azurerm_private_dns_zone.private_dns_zone[0].id


  dynamic "storage" {
    for_each = toset(var.storage != null ? [var.storage] : [])

    content {
      auto_grow_enabled = lookup(storage.value, "auto_grow_enabled", true)
      iops              = lookup(storage.value, "iops", 360)
      size_gb           = lookup(storage.value, "size_gb", 20)
    }
  }

  dynamic "high_availability" {
  for_each = toset((!startswith(var.mysql_sku_name, "B") && var.high_availability != null) ? [var.high_availability] : [])
    content {
      mode                      = lookup(high_availability.value, "mode", null)
      standby_availability_zone = lookup(high_availability.value, "standby_availability_zone", null)
    }
  }

  dynamic "maintenance_window" {
      for_each = toset(var.maintenance_window != null ? [var.maintenance_window] : [])

      content {
        day_of_week  = lookup(maintenance_window.value, "day_of_week", 0)
        start_hour   = lookup(maintenance_window.value, "start_hour", 0)
        start_minute = lookup(maintenance_window.value, "start_minute", 0)
      }
    }

  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  zone                         = var.zone

  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "azurerm_mysql_flexible_database" "mysql_database" {
  for_each = var.create_mysql_fs ? var.mysql_databases : {}

  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server[0].name
  charset             = lookup(each.value, "charset", "utf8")
  collation           = lookup(each.value, "collation", "utf8_unicode_ci")
}

resource "azurerm_mysql_flexible_server_configuration" "example" {
  for_each            = var.server_configurations != null ? var.server_configurations : {}
  name                = each.key
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server.0.name
  value               = lookup(each.value , "value" , null)
}

resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rules" {
  for_each = var.is_public && var.allowed_cidrs != null ? var.allowed_cidrs : {}

  name                = each.key
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server.0.name
  start_ip_address    = lookup(each.value, "start_ip_address" , null)
  end_ip_address      = lookup(each.value, "end_ip_address" , null)
}