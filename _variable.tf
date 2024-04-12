variable "project_name_prefix" {
  description = "Used in tags cluster and nodes"
  type        = string
  default     = "dev"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "CreatedBy" : "Terraform"
  }
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    Project    = "Azure_database",
    Managed-By = "TTN",
  }
}


variable "resource_group_name" {
  description = "The name of the Azure Resource Group where the resources will be created."
  type        = string
  default     = "gaurav"
}

variable "location" {
  description = "The Azure region where the resources will be deployed. E.g., 'East US', 'West Europe', etc."
  type        = string
  default     = "Central India"
}

variable "subnet_name" {
  description = "name of the subnet"
  type        = string
  default     = "database_subnet"
}


variable "vnet_name" {
  description = "name of the virtual network"
  type        = string
  default     = "my-vnet"
}


variable "dns_zone_virtual_network_link_name" {
  description = "The name of the virtual network link for the private DNS zone."
  type        = string
  default     = "vnet-private-zone-link"
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone for the MySQL Flexible Server."
  type        = list(string)
  default     = ["mysql.mysql.database.azure.com", "psql.postgres.database.azure.com"]
}


variable "create_mysql_fs" {
  description = "A boolean flag to determine whether to create the MySQL Flexible Server resources or not."
  type        = bool
  default     = false
}

variable "create_postgresql_fs" {
  description = "A boolean flag to determine whether to create the PostgreSQL Flexible Server resources or not."
  type        = bool
  default     = true
}

variable "create_mariadb" {
  description = "A boolean flag to determine whether to create the MariaDB resources or not."
  type        = bool
  default     = false
}

variable "is_public" {
  description = "to create mysql or postgresql server as publuc or not"
  type        = bool
  default     = false
}

########################################################################################################################################
variable "administrator_login" {
  description = "The Administrator Login for the database Server. Changing this forces a new resource to be created."
  type        = string
  default     = "db_admin"

}

variable "administrator_password" {
  description = "The Password associated with the administrator_login for the database Server."
  type        = string
  sensitive   = true
  default     = "123qwe!@#"
}

variable "auto_grow_enabled" {
  description = "(Optional) Enable or disable incremental automatic growth of database space. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is `true`."
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 7
}


variable "create_mode" {
  description = "The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default.`"
  type        = string
  default     = "Default"
  nullable    = false
}

variable "geo_redundant_backup_enabled" {
  description = "Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
  type        = bool
  default     = false
}


variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this server. Possible values are Enabled and Disabled."
  type        = bool
  default     = false
}


######################################################################################
####                         MYSQL FLEXIBLE SERVER                                ####
######################################################################################


variable "zone" {
  description = "The zone for the MySQL Flexible Server."
  type        = number
  default     = 2

}

variable "storage" {
  description = "Map of the storage configuration"
  type = object({
    auto_grow_enabled = optional(bool)
    iops              = optional(number)
    size_gb           = optional(number)
  })
  default = null
  # {
  #     auto_grow_enabled =  true
  #     iops              =  360
  #     size_gb           =  20
  # }
}

variable "high_availability" {
  description = "Map of high availability configuration: https://docs.microsoft.com/en-us/azure/mysql/flexible-server/concepts-high-availability. `null` to disable high availability"
  type = object({
    mode                      = string
    standby_availability_zone = optional(number)
  })
  default = null
  # {
  #   mode                      = "SameZone"
  #   standby_availability_zone = 1
  # }
}

variable "maintenance_window" {
  description = "Map of maintenance window configuration: https://docs.microsoft.com/en-us/azure/mysql/flexible-server/concepts-maintenance"
  type        = map(number)
  default     = null
}

variable "mysql_fs_server_name" {
  description = "Specifies the name of the MySQL Server. Changing this forces a new resource to be created."
  type        = string
  default     = "terraform-test-mysql-server"
}

variable "mysql_fs_server_version" {
  description = "The version of the MySQL Flexible Server to use. Possible values are 5.7, and 8.0.21. Changing this forces a new resource to be created."
  type        = string
  default     = "8.0.21"
}

variable "mysql_sku_name" {
  description = "Specifies the SKU Name for this MySQL Flexible Server."
  type        = string
  default     = "B_Standard_B1s"
}

variable "mysql_databases" {
  description = "Map of MySQL database configurations"
  type = map(object({
    charset   = string
    collation = string
  }))
  default = {
    # database_1 = {
    #   charset   = "utf8"
    #   collation = "utf8_general_ci"
    # }
    # database_2 = {
    #   charset   = "utf8mb4"
    #   collation = "utf8mb4_general_ci"
    # }
  }
}

variable "server_configurations" {
  description = "Map of MySQL server configurations"
  type = map(object({
    value               = string
  }))
  default = {
    # interactive_timeout = {
    #   value               = "600"
    # }
    # require_secure_transport = {
    #   value               = "ON"
    # }
  }
}

variable "allowed_cidrs" {
  description = "Map of authorized CIDRs"
  type        = map(object({
      start_ip_address = string
      end_ip_address  = string
}))
  default     = {
    # office = {
    #   start_ip_address = "61.12.91.218"
    #   end_ip_address  = "61.12.91.218"
    # }
  }
}

######################################################################################
####                         POSTGRESQL FLEXIBLE SERVER                           ####
######################################################################################

variable "postgres_zone" {
  description = "Specify availability-zone for PostgreSQL Flexible main Server."
  type        = number
  default     = 1

}

variable "postgres_storage_tier" {
  description = " The name of storage performance tier for IOPS of the PostgreSQL Flexible Server."
  type = string
  default =  null
}

variable "postgres_server_name" {
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
  default     = "postgresqlfs-server"
}

variable "postgres_server_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are `9.5`, `9.6`, `10.0`, `10.2` and `11`. Changing this forces a new resource to be created."
  type        = string
  default     = "16"
}

variable "postgres_storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 32768
}

variable "postgres_sku_name" {
  type    = string
  default = "GP_Standard_D4s_v3"
}


variable "postgres_high_availability" {
  description = "Map of high availability configuration: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server. `null` to disable high availability"
  type = object({
    mode                      = string
    standby_availability_zone = optional(number)
  })
  default = null
  # {
  #   mode                      = "SameZone"
  #   standby_availability_zone = 1
  # }
}


variable "postgres_maintenance_window" {
  description = "Map of maintenance window configuration: https://docs.microsoft.com/en-us/azure/mysql/flexible-server/concepts-maintenance"
  type        = map(number)
  default     = null
}

variable "postgres_databases" {
  description = "Map of MySQL database configurations"
  type = map(object({
    charset   = string
    collation = string
  }))
  default = {
    database_1 = {
      charset   = "utf8"
      collation = "en_US.utf8"
    }
    database_2 = {
      charset   = "utf8"
      collation = "en_US.utf8"
    }
  }
}

variable "postgres_server_configurations" {
  description = "PostgreSQL configurations to enable."
   type = map(object({
    value               = string
  }))
  default = {
    # backslash_quote = {
    #   value               = "on"
    # }
    # require_secure_transport = {
    #   value               = "ON"
    # }
  }
}

variable "postgres_firewall_rule" {
  description = "Map of authorized CIDRs"
  type        = map(object({
      start_ip_address = string
      end_ip_address  = string
}))
  default     = {
    # office = {
    #   start_ip_address = "61.12.91.218"
    #   end_ip_address  = "61.12.91.218"
    # }
  }
}
######################################################################################
####                         MARIADB SERVER                                       ####
######################################################################################

variable "private_endpoint_network_policies_enabled" {
  description = "Controls whether network policies for private endpoints should be enabled or not."
  type        = bool
  default     = true
}

variable "private_service_connection_name" {
  description = "The name of the private service connection for the MariaDB server."
  type        = string
  default     = "sqldbprivatelink"
}

variable "private_service_connection_is_manual_connection" {
  description = "Determines if the private service connection is created manually or automatically."
  type        = bool
  default     = false
}

variable "private_service_connection_subresource_names" {
  description = "The list of subresource names for the private service connection."
  type        = list(string)
  default     = ["mariadbServer"]
}

variable "server-name" {
  description = "The name of the MariaDB server."
  type        = string
  default     = "my-mariadb-svr"
}

variable "mariadb_storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 5120
}

variable "mariadb_geo_redundant_backup_enabled" {
  description = "Turn Geo-redundant server backups on/off. Not available for the Basic tier."
  type        = bool
  default     = false
}

variable "ssl_enforcement_enabled" {
  description = "Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled."
  type        = bool
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "(Optional) The minimum TLS version to support on the sever. Possible values are `TLSEnforcementDisabled`, `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_2`. `ssl_minimal_tls_version_enforced` must be set to `TLSEnforcementDisabled` when `ssl_enforcement_enabled` is set to `false`."
  type        = string
  default     = "TLS1_2"
}

variable "mariadb_sku" {
  description = "The SKU (Service Level) for the MariaDB server."
  type        = string
  default     = "GP_Gen5_4"
}

variable "mariadb_version" {
  description = "Specifies the version of MariaDB to use. Possible values are `10.2` and `10.3`"
  type        = string
  default     = "10.2"
}

variable "db-name" {
  description = "The name of the MariaDB database to be created."
  type        = string
  default     = "mariadb_database"
}

variable "databases_charset" {
  description = "Specifies the charset for each MariaDB Database: https://mariadb.com/kb/en/library/setting-character-sets-and-collations/"
  type        = string
  default     = "utf8mb4"
}

variable "databases_collation" {
  description = "Specifies the collation for each MariaDB Database: https://mariadb.com/kb/en/library/setting-character-sets-and-collations/"
  type        = string
  default     = "utf8mb4_unicode_520_ci"
}