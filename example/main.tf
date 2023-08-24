resource "random_password" "passwd" {
  length      = 12
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = false
}

module "database_main" {
  source = "git::https://github.com/tothenew/terraform-azure-databases.git"

  create_mysql_fs      = true
  create_postgresql_fs = false
  create_mariadb       = false

  project_name_prefix = "database"

  resource_group_name = "rg"
  location            = "EAST US 2"
  vnet_name           = "vnet"
  subnet_name         = "db-subnet"

  administrator_login    = "admin"
  administrator_password = element(concat(random_password.passwd.*.result, [""]), 0)
}

