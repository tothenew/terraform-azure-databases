variable "project_name_prefix" {
  description = "Used in tags cluster and nodes"
  type        = string
  default     = "azure_database"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "database"
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
  default     = "rg"
}

variable "location" {
  description = "The Azure region where the resources will be deployed. E.g., 'East US', 'West Europe', etc."
  type        = string
  default     = "EAST US 2"  
}

variable "subnet_name" {
  description = "name of the subnet"
  type        = string
  default     = "mariadb-subnet"
}


variable "vnet_name" {
  description = "name of the virtual network"
  type = string
  default = "vnet1"
}


variable "dns_zone_virtual_network_link_name" {
    description = "The name of the virtual network link for the private DNS zone."
    type        = string
    default     = "vnet-private-zone-link"
}

variable "private_dns_zone_name" {
    description = "The name of the private DNS zone for the MySQL Flexible Server."
    type        = string
    default     = "mydb.database.azure.com"
}


variable "create_mysql_fs" {
    description = "A boolean flag to determine whether to create the MySQL Flexible Server resources or not."
    type        = bool
    default     = false
}

variable "create_postgresql_fs" {
    description = "A boolean flag to determine whether to create the PostgreSQL Flexible Server resources or not."
    type        = bool
    default     = false
}

variable "create_mariadb" {
    description = "A boolean flag to determine whether to create the MariaDB resources or not."
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

variable "db_charset" {
  description = "Specifies the Charset for the Database, which needs to be a valid Charset. Changing this forces a new resource to be created."
  type        = string
  default     = "UTF8"
}

variable "db_collation" {
  description = "Specifies the Collation for the Database, which needs to be a valid Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
  type        = string
  default     = "English_United States.1252"
}

variable "db_names" {
  description = "The list of names of the Database, which needs to be a valid identifier. Changing this forces a new resource to be created."
  type        = string
  default     = "my_db"
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

variable "value" {
  description = " Specifies the value of the MySQL Configuration. See the MySQL documentation for valid values. Changing this forces a new resource to be created."
  type        = string
  default     = "600"
} 

variable "start_ip" {
  description = "Specifies the Start IP Address associated with this Firewall Rule."
  type        = string
  default     = "0.0.0.0"
}

variable "end_ip" {
  description = "Specifies the End IP Address associated with this Firewall Rule. "
  type        = string
  default     = "0.0.0.0"
}

variable "firewall_rule_name" {
  description = "Specifies the name of the MySQL Firewall Rule. "
  type        = string
  default     = "office"
}

variable "zone" {
    description = "The zone for the MySQL Flexible Server."
    type        = number
    default     = 3

}

variable "storagesize_gb" {
    description = "The storage size in GB for the MySQL Flexible Server."
    type        = number
    default     = 128
}

variable "iops" {
    description = "The storage IOPS (Input/Output Operations Per Second) for the MySQL Flexible Server."
    type        = string
    default     = "10000"
}

variable "mysql_fs_server_name" {
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
  default     = "example-fs-server"
}

variable "sql_fs_server_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are `9.5`, `9.6`, `10.0`, `10.2` and `11`. Changing this forces a new resource to be created."
  type        = string
  default     = "12"
}

variable "sql_fs_storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 32768
}

variable "sql_fs_sku_name" {
    description = "The SKU (Stock Keeping Unit) name for the MySQL Flexible Server."
    type        = string
    default     = "GP_Standard_D4s_v3"
}

variable "mysql_fs_db_charset" {
  description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created."
  type        = string
  default     = "UTF8"
}

variable "mysql_fs_db_collation" {
  description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
  type        = string
  default     = "utf8_unicode_ci"
}

variable "mysql_sku_name" {
  description = "Specifies the SKU Name for this MySQL Flexible Server."
  type        = string
  default     = "B_Standard_B1s"
}

variable "server_configuration_name" {
  description = "Specifies the name of the MySQL Configuration, which needs to be a valid MySQL configuration name. Changing this forces a new resource to be created."
  type        = string
  default     = "interactive_timeout"
}

######################################################################################
####                         POSTGRESQL FLEXIBLE SERVER                           ####
######################################################################################

variable "high_availability_mode" {
    description = "The high availability mode for the PostgreSQL Flexible Server."
    type        = string
    default     = "SameZone"
}

variable "fs_server_name" {
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
  default = "example-postgresqlfs-server"
}

variable "fs_server_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are `9.5`, `9.6`, `10.0`, `10.2` and `11`. Changing this forces a new resource to be created."
  type        = string
  default     = "12"
}

variable "fs_storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 32768
}

variable "fs_sku_name" {
  type = string
  default = "GP_Standard_D4s_v3"
}


variable "fs_db_names" {
  description = "The list of names of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created."
  type        = string
  default     = "my_fs_db"
}

variable "fs_db_charset" {
  description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created."
  type        = string
  default     = "UTF8"
}

variable "fs_db_collation" {
  description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
  type        = string
  default     = "en_US.utf8"
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
  default     =  "utf8mb4_unicode_520_ci"
}