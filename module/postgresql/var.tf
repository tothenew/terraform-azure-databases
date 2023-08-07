variable "name_prefix" {
  description = "Used in tags cluster and nodes"
  type        = string
}


variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
}

variable "resource_group" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_id" {}
variable "subnet_name" {}
variable "create_postgresql_fs"{}
variable "address_prefixes" {}
variable "service_endpoints" {}

variable "delegation_name" {}

variable "dns_zone_virtual_network_link_name" {}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this server. Possible values are Enabled and Disabled."
  type        = bool
}


variable "administrator_login" {
  type        = string
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
}

variable "administrator_password" {
  type        = string
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  sensitive   = true
}

variable "high_availability_mode" {
  type = string
}

variable "backup_retention_days" {
  type        = number
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
}

variable "create_mode" {
  type        = string
  description = "(Optional) The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default.`"
  nullable    = false
}


######################################################################################
####                         POSTGRESQL FLEXIBLE SERVER                           ####
######################################################################################

variable "private_dns_zone_postgresql_fs_name" {}

variable "service_delegation_name_postgresql_fs" {}

variable "service_delegation_action_postgresql_fs" {}

variable "fs_server_name" {
  type        = string
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
}

variable "fs_server_version" {
  type        = string
  description = "Specifies the version of PostgreSQL to use. Valid values are `9.5`, `9.6`, `10.0`, `10.2` and `11`. Changing this forces a new resource to be created."
}

variable "fs_storage_mb" {
  type        = number
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
}

variable "fs_sku_name" {
  type = string
}


variable "fs_db_names" {
  type        = string
  description = "The list of names of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created."
}

variable "fs_db_charset" {
  type        = string
  description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created."
}

variable "fs_db_collation" {
  type        = string
  description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
}

