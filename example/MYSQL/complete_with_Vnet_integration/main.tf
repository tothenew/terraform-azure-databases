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

# if you want to create a mysql flexible server as private
  is_public = false

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

  subnet_name         =  "database_subnet"
  vnet_name           =  "my-vnet"
  private_dns_zone_name  = ["mysql.mysql.database.azure.com"]
  dns_zone_virtual_network_link_name = "vnet-private-zone-link"


  administrator_login    = "db_admin"
  administrator_password = element(concat(random_password.passwd.*.result, [""]), 0)
 
  mysql_fs_server_name = "mysql-fs-server"
  mysql_sku_name     =   "B_Standard_B1s"
  mysql_fs_server_version = "8.0.21"
  zone                     = 1
  backup_retention_days    = 7
  create_mode              = "Default"

  geo_redundant_backup_enabled  = false


# if you don't need storage then set storage as null
  storage = {
    auto_grow_enabled =  true
    iops              =  360
    size_gb           =  20
  }

# if you don't need high_availability then set high_availability as null and high_availability is not supported for the Burstable pricing tier. 

  high_availability = {
    mode                      = "SameZone"
    standby_availability_zone = 1
  }

 maintenance_window  = null

# you can create as many as databases else you can set mysql_databases if you don't need the database
 mysql_databases = {
    database_1 = {
      charset   = "utf8"
      collation = "utf8_general_ci"
    }
    # database_2 = {
    #   charset   = "utf8mb4"
    #   collation = "utf8mb4_general_ci"
    # }
 }

# you can add as mamy as server_configurations for mysql else set the value as null if you don't need  
server_configurations = {
  interactive_timeout = {
      value               = "600"
    }
    require_secure_transport = {
      value               = "ON"
    }
}

}

