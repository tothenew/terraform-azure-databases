output "postgresql_fqdn" {
  value = var.create_postgresql_fs == true ? azurerm_postgresql_flexible_server.prostgres_flexible_server.0.fqdn : null
}

output "mysql_fqdn" {
  value = var.create_mysql_fs == true ? azurerm_mysql_flexible_server.mysql_flexible_server.0.fqdn : null
}

output "mariadb_fqdn" {
  value = var.create_mariadb == true ? azurerm_mariadb_server.mariadb_server.0.fqdn : null
}

