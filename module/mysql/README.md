## Terraform Modules Overview - Azure MySQL Flexible Server

This Terraform configuration deploys resources for managing Azure MySQL Flexible Server. It consists of the following modules:

### Module: `azurerm_private_dns_zone`

This module creates a private DNS zone in Azure. It is used to define the private DNS zone for the Azure MySQL Flexible Server.

**Input Variables:**
- `create_mysql_fs`: A boolean flag to determine whether to create the Azure MySQL Flexible Server resources or not.
- `private_dns_zone_mysql_fs_name`: The name of the private DNS zone.
- `resource_group`: The name of the resource group where the private DNS zone will be created.

**Usage Example:**
```
resource "private_dns_zone" {
  private_dns_zone_mysql_fs_name = "myprivatednszone.local"
  resource_group                = azurerm_resource_group.rg.name
}
```

### Module: `azurerm_private_dns_zone_virtual_network_link`

This module creates a virtual network link for the private DNS zone. It links the virtual network to the private DNS zone for Azure MySQL Flexible Server.

**Input Variables:**
- `create_mysql_fs`: A boolean flag to determine whether to create the Azure MySQL Flexible Server resources or not.
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

### Module: `azurerm_mysql_flexible_server`

This module creates the Azure MySQL Flexible Server.

**Input Variables:**
- `create_mysql_fs`: A boolean flag to determine whether to create the Azure MySQL Flexible Server resources or not.
- `mysql_fs_server_name`: The name of the Azure MySQL Flexible Server.
- `resource_group`: The name of the resource group where the Azure MySQL Flexible Server will be created.
- `location`: The location where the Azure MySQL Flexible Server will be deployed.
- `administrator_login`: The administrator login name for the Azure MySQL Flexible Server.
- `administrator_password`: The administrator password for the Azure MySQL Flexible Server.
- `mysql_sku_name`: The SKU of the Azure MySQL Flexible Server.
- `backup_retention_days`: The number of days to retain backups.
- `create_mode`: The mode for creating the Azure MySQL Flexible Server.
- `delegated_subnet_id`: The ID of the subnet to which the Azure MySQL Flexible Server will be delegated.
- `private_dns_zone_id`: The ID of the private DNS zone associated with the Azure MySQL Flexible Server.
- `auto_grow_enabled`: A boolean flag to enable or disable auto-growth of storage for the Azure MySQL Flexible Server.
- `iops`: The number of IOPS (Input/Output Operations Per Second) for the Azure MySQL Flexible Server storage.
- `storagesize_gb`: The storage size in GB for the Azure MySQL Flexible Server.
- `geo_redundant_backup_enabled`: A boolean flag to enable or disable geo-redundant backup.
- `zone`: The availability zone for the Azure MySQL Flexible Server.
- `tags`: A map of tags to assign to the Azure MySQL Flexible Server.

**Usage Example:**
```
module "mysql_flexible_server" {
  create_mysql_fs                 = true
  mysql_fs_server_name            = "my-mysql-server"
  resource_group                  = azurerm_resource_group.rg.name
  location                        = var.location
  administrator_login             = "adminuser"
  administrator_password          = "Strong@Password!"
  mysql_sku_name                  = "Standard_B1ms"
  backup_retention_days           = 7
  create_mode                     = "Default"
  delegated_subnet_id             = azurerm_subnet.mysql_db_subnet.id
  private_dns_zone_id             = azurerm_private_dns_zone.private_dns_zone.id
  auto_grow_enabled               = true
  iops                            = 100
  storagesize_gb                  = 512
  geo_redundant_backup_enabled    = true
  zone                            = "1"

}
```

### Module: `azurerm_mysql_flexible_database`

This module creates a database within the Azure MySQL Flexible Server.

**Input Variables:**
- `create_mysql_fs`: A boolean flag to determine whether to create the Azure MySQL Flexible Server resources or not.
- `db_names`: The name of the database.
- `resource_group`: The name of the resource group where the database will be created.
- `mysql_fs_db_charset`: The character set for the database.
- `mysql_fs_db_collation`: The collation for the database.

**Usage Example:**
```
resource "mysql_flexible_database" {
  db_names              = "mydatabase"
  resource_group        = azurerm_resource_group.rg.name
  mysql_fs_db_charset   = "utf8"
  mysql_fs_db_collation = "utf8_general_ci"
}
```

### Note

Ensure that you have the required provider block for Azure before using this configuration. Also, update the values of input variables as per your requirements before running Terraform commands.

Note: Please refer to the module documentation for additional optional variables and their descriptions.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server