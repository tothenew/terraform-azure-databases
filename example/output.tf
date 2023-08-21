output "postgresql_fqdn" {
  value =  module.Postgresql.postgresql_fqdn 
}

output "mysql_fqdn" {
   value = module.mysql.mysql_fqdn  
}

output "mariadb_fqdn" {
  value = module.mariadb.mariadb_fqdn
}