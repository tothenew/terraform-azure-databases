output "mysql_fqdn" {
  value = var.create_mysql_fs == true ? azurerm_mysql_flexible_server.mysql_flexible_server.0.fqdn : null
}