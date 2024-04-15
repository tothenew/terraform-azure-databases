terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
} 


resource "random_password" "passwd" {
  length      = 12
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = false
}



module "database_main" {
  source = "git::https://github.com/tothenew/terraform-azure-databases.git"

  create_postgresql_fs      = true

  # if you want to create a mysql flexible server as public then set is_public = true
  is_public = true

  project_name_prefix = "dev"
  
  default_tags = {
    "CreatedBy" : "Terraform"
  }
  
  common_tags = {
    Project    = "Azure_database",
    Managed-By = "TTN",
  }

# provide the name of your existing resource_group
  resource_group_name = "rg"
  location            = "EAST US 2"

  administrator_login    = "db_admin"
  administrator_password = element(concat(random_password.passwd.*.result, [""]), 0)
 
  postgres_server_name = "postgresql-fs-server"
  postgres_sku_name             =   "B_Standard_B1s"
  postgres_storage_mb           = 32768
  postgres_server_version = "16"
  postgres_zone                     = 1
  backup_retention_days    = 7
  create_mode              = "Default"
  auto_grow_enabled        = false

  geo_redundant_backup_enabled  = false
  # you can create as many as databases else you can set mysql_databases if you don't need the database
 postgres_databases = {
    database_1 = {
      charset   = "utf8"
      collation = "utf8_general_ci"
    }
    # database_2 = {
    #   charset   = "utf8mb4"
    #   collation = "utf8mb4_general_ci"
    # }
 }
}

