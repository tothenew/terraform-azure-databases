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


# if you want to create a mysql flexible server as public then set is_public = true
  is_public = true

  create_postgresql_fs      = true

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

  #Default value is dependant on the storage_mb value. 
  postgres_storage_tier         =  "P30"

  postgres_server_version = "16"
  postgres_zone                     = 1
  backup_retention_days    = 7
  create_mode              = "Default"
  auto_grow_enabled        = false

  geo_redundant_backup_enabled  = false

# you can create as many as databases else you can set postgresql_databases or set as null if you don't need the database
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


# if you don't need high_availability then set high_availability as null and high_availability is not supported for the Burstable pricing tier. 

  postgres_high_availability = {
    mode                      = "SameZone"
    standby_availability_zone = 1
  }

 maintenance_window  = null

# you can add as mamy as server_configurations for mysql else set the value as null if you don't need  
postgres_server_configurations = {
    require_secure_transport = {
      value               = "ON"
    }
}

# firewall rule for mysql to allow specific ip you can specific as many ip rule  else set the value as null if you don't need  
allowed_cidrs = { 
   rule1 = {
      start_ip_address = "0.0.0.0"
      end_ip_address  = "255.255.255.255"
    }

}
}

