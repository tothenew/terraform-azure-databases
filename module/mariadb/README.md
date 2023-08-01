## Terraform Module Overview - Azure MariaDB Server with Private Endpoint

This Terraform configuration deploys resources for managing MariaDB servers with private endpoint integration in Azure. It consists of the following modules:

### Module: `azurerm_subnet`

This module creates a subnet within a virtual network. It is used to define the subnet where the MariaDB server with private endpoint will reside.

**Input Variables:**
- `create_mariadb`: A boolean flag to determine whether to create the MariaDB resources or not.
- `subnet_name`: The name of the subnet.
- `resource_group`: The name of the resource group where the subnet should be created.
- `vnet_name`: The name of the virtual network to which the subnet belongs.
- `address_prefixes`: The list of address prefixes to be used for the subnet.
- `private_endpoint_network_policies_enabled`: A boolean flag to enable or disable network policies for private endpoint.

**Usage Example:**
```
module "subnet" {
  source                             = "./module/subnet"
  create_mariadb                     = var.create_mariadb
  subnet_name                        = "my-subnet"
  resource_group                     = azurerm_resource_group.example.name
  vnet_name                          = azurerm_virtual_network.example.name
  address_prefixes                   = ["10.0.2.0/24"]
  private_endpoint_network_policies_enabled = true
}
```

### Module: `azurerm_private_endpoint`

This module creates a private endpoint for the MariaDB server. It establishes a private connection to the MariaDB server within the specified subnet.

**Input Variables:**
- `create_mariadb`: A boolean flag to determine whether to create the MariaDB resources or not.
- `server-name`: The name of the MariaDB server for which the private endpoint will be created.
- `location`: The location of the resource group where the private endpoint will be deployed.
- `resource_group`: The name of the resource group where the private endpoint will be created.
- `private_service_connection_name`: The name of the private service connection.
- `private_service_connection_is_manual_connection`: A boolean flag to determine if the connection is manual.
- `private_service_connection_subresource_names`: The list of subresource names for the private service connection.

**Usage Example:**
```
module "private_endpoint" {
  source                                  = "./module/private_endpoint"
  create_mariadb                          = var.create_mariadb
  server-name                             = "mariadb-server"
  location                                = var.location
  resource_group                          = azurerm_resource_group.example.name
  private_service_connection_name         = "private-mariadb-connection"
  private_service_connection_is_manual_connection = false
  private_service_connection_subresource_names    = ["mysqlServer"]
}
```

### Module: `azurerm_mariadb_server`

This module creates the MariaDB server in Azure.

**Input Variables:**
- `create_mariadb`: A boolean flag to determine whether to create the MariaDB resources or not.
- `server-name`: The name of the MariaDB server.
- `location`: The location where the MariaDB server will be deployed.
- `resource_group`: The name of the resource group where the MariaDB server will be created.
- `administrator_login`: The administrator login name for the MariaDB server.
- `administrator_password`: The administrator password for the MariaDB server.
- `mariadb_sku`: The SKU of the MariaDB server.
- `mariadb_storage_mb`: The storage capacity for the MariaDB server in MB.
- `mariadb_version`: The version of the MariaDB server.
- `auto_grow_enabled`: A boolean flag to enable or disable auto-growth of storage.
- `backup_retention_days`: The number of days to retain backups.
- `mariadb_geo_redundant_backup_enabled`: A boolean flag to enable or disable geo-redundant backup.
- `public_network_access_enabled`: A boolean flag to enable or disable public network access.
- `ssl_enforcement_enabled`: A boolean flag to enable or disable SSL enforcement.
- `ssl_minimal_tls_version_enforced`: The minimal TLS version enforced on the MariaDB server.
- `tags`: A map of tags to assign to the MariaDB server.

**Usage Example:**
```
module "mariadb_server" {
  source                                = "./module/mariadb_server"
  create_mariadb                        = var.create_mariadb
  server-name                           = "mariadb-server"
  location                              = var.location
  resource_group                        = azurerm_resource_group.example.name
  administrator_login                   = "mariadbadmin"
  administrator_password                = "Strong@Password!"
  mariadb_sku                           = "GP_Gen5_2"
  mariadb_storage_mb                    = 51200
  mariadb_version                       = "10.4"
  auto_grow_enabled                     = true
  backup_retention_days                 = 7
  mari

adb_geo_redundant_backup_enabled  = true
  public_network_access_enabled         = false
  ssl_enforcement_enabled               = true
  ssl_minimal_tls_version_enforced      = "TLSEnforcementDisabled"
  tags                                  = {
    environment = "development"
    project     = "my-mariadb-project"
  }
}
```

### Module: `azurerm_private_dns_zone`

This module creates a private DNS zone in Azure.

**Input Variables:**
- `create_mariadb`: A boolean flag to determine whether to create the MariaDB resources or not.
- `mariadb_private_dns_zone_name`: The name of the private DNS zone.
- `resource_group`: The name of the resource group where the private DNS zone will be created.
- `tags`: A map of tags to assign to the private DNS zone.

**Usage Example:**
```
module "private_dns_zone" {
  source                                  = "./module/private_dns_zone"
  create_mariadb                          = var.create_mariadb
  mariadb_private_dns_zone_name           = "my-private-dns-zone"
  resource_group                          = azurerm_resource_group.example.name
  tags                                    = {
    environment = "development"
    project     = "my-mariadb-project"
  }
}
```

### Module: `azurerm_private_dns_zone_virtual_network_link`

This module creates a virtual network link for the private DNS zone.

**Input Variables:**
- `create_mariadb`: A boolean flag to determine whether to create the MariaDB resources or not.
- `dns_zone_virtual_network_link_name`: The name of the virtual network link for the private DNS zone.
- `resource_group`: The name of the resource group where the virtual network link will be created.
- `private_dns_zone_name`: The name of the private DNS zone.
- `virtual_network_id`: The ID of the virtual network to which the link will be created.
- `tags`: A map of tags to assign to the virtual network link.

**Usage Example:**
```
module "private_dns_zone_link" {
  source                                  = "./module/private_dns_zone_link"
  create_mariadb                          = var.create_mariadb
  dns_zone_virtual_network_link_name      = "my-dns-zone-link"
  resource_group                          = azurerm_resource_group.example.name
  private_dns_zone_name                   = "my-private-dns-zone"
  virtual_network_id                      = azurerm_virtual_network.example.id
  tags                                    = {
    environment = "development"
    project     = "my-mariadb-project"
  }
}
```

### Module: `azurerm_mariadb_database`

This module creates a database within the MariaDB server.

**Input Variables:**
- `create_mariadb`: A boolean flag to determine whether to create the MariaDB resources or not.
- `db-name`: The name of the database.
- `resource_group`: The name of the resource group where the database will be created.
- `server_name`: The name of the MariaDB server to which the database belongs.
- `charset`: The character set for the database.
- `collation`: The collation for the database.

**Usage Example:**
```
module "mariadb_database" {
  source                                = "./module/mariadb_database"
  create_mariadb                        = var.create_mariadb
  db-name                               = "my-database"
  resource_group                        = azurerm_resource_group.example.name
  server_name                           = azurerm_mariadb_server.example1.name
  charset                               = "utf8"
  collation                             = "utf8_general_ci"
}
```

**Note:**

Ensure that you have the required provider block for Azure before using this configuration. Also, update the values of input variables as per your requirements before running Terraform commands.

Please refer to the input variable descriptions in each module for more details on their usage.