

output "postgresql_fqdn" {
  value = module.database_main.postgresql_fqdn
}

output "mysql_fqdn" {
  value = module.database_main.mysql_fqdn
}

output "mariadb_fqdn" {
  value = module.database_main.mariadb_fqdn
}
