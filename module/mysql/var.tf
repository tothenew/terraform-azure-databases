variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

variable "resource_group" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_id" {}
variable "subnet_id" {}
variable "dns_zone_virtual_network_link_name" {}
variable "create_mysql_fs" {}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this server. Possible values are Enabled and Disabled."
  type        = bool
}


variable "administrator_login" {
  type        = string
  description = "The Administrator Login for the MYSQL Server. Changing this forces a new resource to be created."
}

variable "administrator_password" {
  type        = string
  description = "The Password associated with the administrator_login for the MYSQL Server."
  sensitive   = true
}

variable "db_names" {
  type        = string
  description = "The list of names of the MYSQL Database, which needs to be a valid MYSQL identifier. Changing this forces a new resource to be created."
}

variable "backup_retention_days" {
  type        = number
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
}

 variable "create_mode" {
  type        = string
  description = "(Optional) The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default.`"
}



######################################################################################
####                         MYSQL FLEXIBLE SERVER                                ####
######################################################################################
variable "private_dns_zone_mysql_fs_name" {
  type = string
}

# variable "service_delegation_name_mysql_fs" {
#   type = string
# }

# variable "service_delegation_action_mysql_fs" {
# }

variable "mysql_fs_server_name" {
  type = string
}

variable "mysql_sku_name" {
  description = "Specifies the SKU Name for this MySQL Flexible Server."
}

variable "storagesize_gb" {
  description = "Specifies the version of MySQL to use."
}

variable "iops" {
  description = "The storage IOPS for the MySQL Flexible Server."
}

variable "geo_redundant_backup_enabled" {
  description = "Is Geo-Redundant backup enabled on the PostgreSQL Flexible Server."
  type        = bool
}

variable "auto_grow_enabled" {
  type = bool
}

variable "zone" {
}

variable "mysql_fs_db_charset" {
  type        = string
  description = "Specifies the Charset for the SQL Database, which needs to be a valid SQL Charset. Changing this forces a new resource to be created."
}

variable "mysql_fs_db_collation" {
  type        = string
  description = "Specifies the Collation for the SQL Database, which needs to be a valid SQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
}


variable "firewall_rule_name" {
  type        = string
  description = "Specifies the name of the MySQL Firewall Rule. "
}

variable "start_ip" {
  type        = string
  description = "Specifies the Start IP Address associated with this Firewall Rule."

}

variable "end_ip" {
  type        = string
  description = "Specifies the End IP Address associated with this Firewall Rule. "
}

variable "server_configuration_name" {
  type        = string
  description = "Specifies the name of the MySQL Configuration, which needs to be a valid MySQL configuration name. Changing this forces a new resource to be created."
}


variable "value" {
  type        = string
  description = " Specifies the value of the MySQL Configuration. See the MySQL documentation for valid values. Changing this forces a new resource to be created."
} 
