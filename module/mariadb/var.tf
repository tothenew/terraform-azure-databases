variable "name_prefix" {
  description = "Used in tags cluster and nodes"
  type        = string
  default     = "Azure_cosmmosdb"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "Cosmosdb"
    "CreatedBy" : "Terraform"
  }
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    Project    = "Azure_Cosmosdb",
    Managed-By = "TTN",
  }
}

variable "resource_group" {
  type = string
}
variable "location" {
   type = string
}


variable "create_mariadb"{}

variable "vnet_name" {}
variable "vnet_id" {}
variable "subnet_name" {}

variable "server-name" {
  type = string
}

variable "address_prefixes" {
}

variable "dns_zone_virtual_network_link_name" {
  type = string
}

variable "private_endpoint_network_policies_enabled" {
  type = bool
}

variable "private_service_connection_name" {
  type = string
}

variable "private_service_connection_is_manual_connection" {
  type = bool
}

variable "private_service_connection_subresource_names" {
  type = list(string)
}

variable "mariadb_private_dns_zone_name" {
  type = string
}



variable "administrator_login" {
  description = "MariaDB administrator login."
  type        = string
}

variable "administrator_password" {
  description = "MariaDB administrator password. Auto-generated if empty. Strong Password: https://docs.microsoft.com/en-us/sql/relational-databases/security/strong-passwords?view=sql-server-2017"
  type        = string
}


variable "auto_grow_enabled" {
  description = "Enable/Disable auto-growing of the storage."
  type        = bool
}

variable "mariadb_storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
}

variable "mariadb_geo_redundant_backup_enabled" {
  description = "Turn Geo-redundant server backups on/off. Not available for the Basic tier."
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Enable public network access for this MariaDB server."
  type        = bool
 
}

variable "mariadb_sku" {
  type = string
}

variable "mariadb_version" {
  description = "Specifies the version of MariaDB to use. Possible values are `10.2` and `10.3`"
  type        = string
}

variable "ssl_enforcement_enabled" {
  description = "Specifies if SSL should be enforced on connections."
  type        = bool
}

variable "ssl_minimal_tls_version_enforced" {
}

variable "db-name" {
  type = string
}
variable "databases_charset" {
  description = "Specifies the charset for each MariaDB Database: https://mariadb.com/kb/en/library/setting-character-sets-and-collations/"
  type        = string
}

variable "databases_collation" {
  description = "Specifies the collation for each MariaDB Database: https://mariadb.com/kb/en/library/setting-character-sets-and-collations/"
  type        = string
}