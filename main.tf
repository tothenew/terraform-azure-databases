locals {
  project     = var.project
  environment = var.environment
}

module "resource_group" {
  source                  = "./module/resourcesgroup"
  project                 = local.project
  environment             = local.environment

  resource_group_name     = var.resource_group_name
  location                = var.location
}

module "networking" {
  source                = "./module/networking"
  project               = local.project
  environment           = local.environment

  location              = module.resource_group.location_id
  resource_group        = module.resource_group.resource_group_name
  vnet-name             = var.vnet-name
  vnetcidr              = var.vnetcidr
}

module "mysql" {
  source                                   = "./module/mysql"
  project                                  = local.project
  environment                              = local.environment

  resource_group                           = module.resource_group.resource_group_name
  location                                 = module.resource_group.location_id
  vnet_name                                = module.networking.vnet_name
  vnet_id                                  = module.networking.vnet_id
  subnet_name                              = var.subnet_name
  address_prefixes                         = var.address_prefixes
  service_endpoints                        = var.service_endpoints
  delegation_name                          = var.delegation_name
  dns_zone_virtual_network_link_name       = var.dns_zone_virtual_network_link_name

  create_mysql_fs                          = var.create_mysql_fs
  
  administrator_login                      = var.administrator_login
  administrator_password                   = var.administrator_password
  db_names                                 = var.db_names
  backup_retention_days                    = var.backup_retention_days
  create_mode                              = var.create_mode
 
  private_dns_zone_mysql_fs_name           = var.private_dns_zone_mysql_fs_name
  service_delegation_name_mysql_fs         = var.service_delegation_name_mysql_fs
  service_delegation_action_mysql_fs       = var.service_delegation_action_mysql_fs

  mysql_fs_server_name                     = var.mysql_fs_server_name
  auto_grow_enabled                        = var.auto_grow_enabled
  iops                                     = var.iops
  mysql_sku_name                           = var.mysql_sku_name
  storagesize_gb                           = var.storagesize_gb
  geo_redundant_backup_enabled             = var.geo_redundant_backup_enabled
  zone                                     = var.zone
  mysql_fs_db_charset                      = var.mysql_fs_db_charset
  mysql_fs_db_collation                    = var.mysql_fs_db_collation
  firewall_rule_name                       = var.firewall_rule_name
  start_ip                                 = var.start_ip
  end_ip                                   = var.end_ip
  server_configuration_name                = var.server_configuration_name
  value                                    = var.value  

}

module "Postgresql" {
  source                                   = "./module/postgresql"
  project                                  = local.project
  environment                              = local.environment

  create_postgresql_fs                     = var.create_postgresql_fs
  
  resource_group                           = module.resource_group.resource_group_name
  location                                 = module.resource_group.location_id
  vnet_name                                = module.networking.vnet_name
  vnet_id                                  = module.networking.vnet_id
  subnet_name                              = var.subnet_name
  address_prefixes                         = var.address_prefixes
  service_endpoints                        = var.service_endpoints
  delegation_name                          = var.delegation_name
  dns_zone_virtual_network_link_name       = var.dns_zone_virtual_network_link_name

  administrator_login                      = var.administrator_login
  administrator_password                   = var.administrator_password
  backup_retention_days                    = var.backup_retention_days
  create_mode                              = var.create_mode
  high_availability_mode                   = var.high_availability_mode

  service_delegation_name_postgresql_fs    = var.service_delegation_name_postgresql_fs
  service_delegation_action_postgresql_fs  = var.service_delegation_action_postgresql_fs
  private_dns_zone_postgresql_fs_name      = var.private_dns_zone_postgresql_fs_name

  fs_server_name                           = var.fs_server_name
  fs_server_version                        = var.fs_server_version
  fs_storage_mb                            = var.fs_storage_mb
  fs_sku_name                              = var.fs_sku_name
  fs_db_names                              = var.fs_db_names
  fs_db_collation                          = var.fs_db_collation
  fs_db_charset                            = var.fs_db_charset

}

module "mariadb" {
  source                                   = "./module/mariadb"
  project                                  = local.project
  environment                              = local.environment

  create_mariadb                           = var.create_mariadb
  resource_group                           = module.resource_group.resource_group_name
  location                                 = module.resource_group.location_id

  vnet_name                                = module.networking.vnet_name
  vnet_id                                  = module.networking.vnet_id
  subnet_name                              = var.subnet_name
  address_prefixes                         = var.address_prefixes

  dns_zone_virtual_network_link_name              = var.dns_zone_virtual_network_link_name
  private_endpoint_network_policies_enabled       = var.private_endpoint_network_policies_enabled 
  private_service_connection_name                 = var.private_service_connection_name
  private_service_connection_is_manual_connection = var.private_service_connection_is_manual_connection
  private_service_connection_subresource_names    = var.private_service_connection_subresource_names
  mariadb_private_dns_zone_name                   = var.mariadb_private_dns_zone_name

  server-name                              = var.server-name
  administrator_login                      = var.administrator_login
  administrator_password                   = var.administrator_password
  mariadb_sku                              = var.mariadb_sku
  mariadb_storage_mb                       = var.mariadb_storage_mb
  mariadb_version                          = var.mariadb_version

  auto_grow_enabled                        = var.auto_grow_enabled
  backup_retention_days                    = var.backup_retention_days
  mariadb_geo_redundant_backup_enabled     = var.mariadb_geo_redundant_backup_enabled
  public_network_access_enabled            = var.public_network_access_enabled
  ssl_enforcement_enabled                  = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced         = var.ssl_minimal_tls_version_enforced
  db-name                                  = var.db-name
  databases_charset                        = var.databases_charset
  databases_collation                      = var.databases_collation
}