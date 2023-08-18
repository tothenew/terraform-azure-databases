output "mariadb_fqdn" {
  value = var.create_mariadb == true ? azurerm_mariadb_server.mariadb_server.0.fqdn : null
}