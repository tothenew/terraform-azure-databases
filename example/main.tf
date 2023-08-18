module "database_main" {
  source                                   = "git::https://github.com/tothenew/terraform-azure-databases.git?ref=database-v1"
  
  create_mysql_fs                          = false
  create_postgresql_fs                     = false
  create_mariadb                           = false

  project_name_prefix                      = "database"
  
  resource_group_name                      = "database-rg"
  location                                 = "EAST US 2" 
  vnet_name                                = "myvnet"
  subnet_name                              = "db-subnet"
}

