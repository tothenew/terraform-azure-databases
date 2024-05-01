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

  create_mysql_fs      = true

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
 
  server-name  = "my-mariadb-svr"
  mariadb_sku     =   "B_Standard_B1s"
  mariadb_storage_mb  = 5120
  mariadb_version = "10.2"
  auto_grow_enabled = false
  public_network_access_enabled = false
  mariadb_geo_redundant_backup_enabled = false
  ssl_enforcement_enabled   = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  zone                     = 1
  backup_retention_days    = 7
  create_mode              = "Default"
  
  db-name = "database1"
  databases_charset =   "utf8mb4"
  databases_collation  = "utf8mb4_unicode_520_ci"

  geo_redundant_backup_enabled  = false

  private_endpoint_network_policies_enabled  = true
  private_service_connection_name   = "sqldbprivatelink"
  private_service_connection_is_manual_connection = false

  private_service_connection_subresource_names = ["mariadbServer"]


}

