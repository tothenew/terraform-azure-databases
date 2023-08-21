## Terraform Module Overview - Azure PostgreSQL Flexible Server

This Terraform configuration deploys resources for managing Azure PostgreSQL Flexible Server. It consists of the following modules:

### Module: `azurerm_private_dns_zone`

This module creates a private DNS zone in Azure. It is used to define the private DNS zone for the Azure PostgreSQL Flexible Server.

**Input Variables:**
- `create_postgresql_fs`: A boolean flag to determine whether to create the Azure PostgreSQL Flexible Server resources or not.
- `private_dns_zone_postgresql_fs_name`: The name of the private DNS zone.
- `resource_group`: The name of the resource group where the private DNS zone will be created.

**Usage Example:**
```
resource "private_dns_zone" {
  private_dns_zone_postgresql_fs_name = "myprivatednszone.local"
  resource_group                = azurerm_resource_group.rg.name
}
```

### Module: `azurerm_private_dns_zone_virtual_network_link`

This module creates a virtual network link for the private DNS zone. It links the virtual network to the private DNS zone for Azure PostgreSQL Flexible Server.

**Input Variables:**
- `create_postgresql_fs`: A boolean flag to determine whether to create the Azure PostgreSQL Flexible Server resources or not.
- `dns_zone_virtual_network_link_name`: The name of the virtual network link for the private DNS zone.
- `private_dns_zone_name`: The name of the private DNS zone.
- `virtual_network_id`: The ID of the virtual network to which the link will be created.
- `resource_group`: The name of the resource group where the virtual network link will be created.

**Usage Example:**
```
resource "private_dns_zone_virtual_network_link" {
  dns_zone_virtual_network_link_name      = "my-vnet-link"
  private_dns_zone_name                  = "myprivatednszone.local"
  virtual_network_id                     = azurerm_virtual_network.vnet.id
  resource_group                         = azurerm_resource_group.rg.name
}
```

### Module: `azurerm_postgresql_flexible_server`

This module creates the Azure PostgreSQL Flexible Server.

**Input Variables:**
- `create_postgresql_fs`: A boolean flag to determine whether to create the Azure PostgreSQL Flexible Server resources or not.
- `fs_server_name`: The name of the Azure PostgreSQL Flexible Server.
- `resource_group`: The name of the resource group where the Azure PostgreSQL Flexible Server will be created.
- `location`: The location where the Azure PostgreSQL Flexible Server will be deployed.
- `fs_server_version`: The version of Azure PostgreSQL Flexible Server to be used.
- `administrator_login`: The administrator login name for the Azure PostgreSQL Flexible Server.
- `administrator_password`: The administrator password for the Azure PostgreSQL Flexible Server.
- `fs_storage_mb`: The storage size in MB for the Azure PostgreSQL Flexible Server.
- `fs_sku_name`: The SKU of the Azure PostgreSQL Flexible Server.
- `backup_retention_days`: The number of days to retain backups.
- `create_mode`: The mode for creating the Azure PostgreSQL Flexible Server.
- `high_availability_mode`: The high availability mode for the Azure PostgreSQL Flexible Server.
- `delegated_subnet_id`: The ID of the subnet to which the Azure PostgreSQL Flexible Server will be delegated.
- `private_dns_zone_id`: The ID of the private DNS zone associated with the Azure PostgreSQL Flexible Server.
- `tags`: A map of tags to assign to the Azure PostgreSQL Flexible Server.

**Usage Example:**
```
resource "postgresql_flexible_server" {
  create_postgresql_fs            = true
  fs_server_name                  = "my-postgresql-server"
  resource_group                  = azurerm_resource_group.rg.name
  location                        = var.location
  fs_server_version               = "12"
  administrator_login             = "adminuser"
  administrator_password          = "Strong@Password!"
  fs_storage_mb                  = 51200
  fs_sku_name                     = "Standard_B1ms"
  backup_retention_days           = 7
  create_mode                     = "Default"
  high_availability_mode          = "ZoneRedundant"
  delegated_subnet_id             = azurerm_subnet.example1.id
  private_dns_zone_id             = azurerm_private_dns_zone.example.id


}
```

### Module: `azurerm_postgresql_flexible_server_database`

This module creates a database within the Azure PostgreSQL Flexible Server.

**Input Variables:**
- `create_postgresql_fs`: A boolean flag to determine whether to create the Azure PostgreSQL Flexible Server resources or not.
- `fs_db_names`: The name of the database.
- `resource_group`: The name of the resource group where the database will be created.
- `fs_db_collation`: The collation for the database.
- `fs_db_charset`: The character set for the database.

**Usage Example:**
```
resource "postgresql_flexible_server_database" {
  source                = "./module/postgresql_flexible_server_database"
  create_postgresql_fs  = var.create_postgresql_fs
  fs_db_names           = "mydatabase"
  resource_group        = azurerm_resource_group.rg.name
  fs_db_collation       = "en_US.UTF8"
  fs_db_charset         = "UTF8"
}
```

### Note

Ensure that you have the required provider block for Azure before using this configuration. Also, update the values of input variables as per your requirements before running Terraform commands.

Note: Please refer to the module documentation for additional optional variables and their descriptions.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server