resource "random_password" "passwd" {
  length      = 12
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = false
}

module "database_main" {
  source = "git::https://github.com/gauravnegi01/terraform-azure-databases.git?ref=database-v1"

  create_mysql_fs      = true
  create_postgresql_fs = false
  create_mariadb       = false

  project_name_prefix = "database"

  resource_group_name = "kjnvjnvne_group"
  location            = "West US"
  vnet_name           = "vnet1"
  subnet_name         = "db-subnet"

  administrator_password = element(concat(random_password.passwd.*.result, [""]), 0)
}

