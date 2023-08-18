output "postgresql_fqdn" {
  value = var.create_postgresql_fs == true ? azurerm_postgresql_flexible_server.prostgres_flexible_server.0.fqdn : null
}
