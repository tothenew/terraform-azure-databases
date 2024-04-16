######################################################################################
####                         POSTGRESQL FLEXIBLE SERVER                           ####
######################################################################################

resource "azurerm_postgresql_flexible_server" "prostgres_flexible_server" {
  count                  = var.create_postgresql_fs ? 1 : 0
  name                   = var.postgres_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgres_server_version
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  storage_mb             = var.postgres_storage_mb
  sku_name               = var.postgres_sku_name
  backup_retention_days  = var.backup_retention_days
  create_mode            = var.create_mode
  zone                   = var.postgres_zone
  storage_tier           = var.postgres_storage_tier != null ? var.postgres_storage_tier : null
  auto_grow_enabled      = var.auto_grow_enabled != null ? var.auto_grow_enabled : null
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled != null ? var.geo_redundant_backup_enabled : null


  dynamic "high_availability" {
    for_each = var.postgres_high_availability != null ? [1] : []
    content {
      mode                      = lookup(var.postgres_high_availability, "mode", null)
      standby_availability_zone = lookup(var.postgres_high_availability, "standby_availability_zone", null)
    }
  }

  dynamic "maintenance_window" {
    for_each = var.postgres_maintenance_window != null ? [1] : []
      content {
        day_of_week  = lookup(var.postgres_maintenance_window, "day_of_week", 0)
        start_hour   = lookup(var.postgres_maintenance_window, "start_hour", 0)
        start_minute = lookup(var.postgres_maintenance_window, "start_minute", 0)
    }
  }
  delegated_subnet_id = var.is_public ? null : data.azurerm_subnet.db_subnet[0].id
  private_dns_zone_id = var.is_public ? null : azurerm_private_dns_zone.private_dns_zone[0].id

  tags = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "azurerm_postgresql_flexible_server_database" "postgres_database" {
  for_each = var.create_postgresql_fs ? var.postgres_databases : {}

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.prostgres_flexible_server[0].id
  charset             = lookup(each.value, "charset", "utf8")
  collation           = lookup(each.value, "collation", "en_US.utf8")

   # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_postgresql_flexible_server_configuration" "example" {
  for_each     = var.create_postgresql_fs  == true && var.postgres_server_configurations != null ? var.postgres_server_configurations : {}

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.prostgres_flexible_server[0].id
  value     = lookup(each.value , "value" , null)
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "firewall_rule" {
  for_each = var.create_postgresql_fs  == true  && var.is_public == true && var.postgres_firewall_rule != null ? var.postgres_firewall_rule : {}

  name                = each.key
  server_id           = azurerm_postgresql_flexible_server.prostgres_flexible_server[0].id
  start_ip_address    = lookup(each.value, "start_ip_address" , null)
  end_ip_address      = lookup(each.value, "end_ip_address" , null)
}