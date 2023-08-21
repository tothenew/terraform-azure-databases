# terraform-azure-databases 

[![Lint Status](https://github.com/tothenew/terraform-azure-databases/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-azure-databases )](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

This module sets up different types of databases in Azure, including 
- MYSQL flexible server 
- PostgreSQL flexible server
- MariaDB server

## Prerequisites

Before you begin, ensure you have the following requirements met:

1. Install Terraform (>= 1.3.0). You can download the latest version of Terraform from the official website: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

2. Azure CLI installed and configured with appropriate access rights. You can install the Azure CLI from [https://docs.microsoft.com/en-us/cli/azure/install-azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

3. A Database subnet needs to be created with appropriate SUBNET DELEGATION or NETWORK POLICY FOR PRIVATE ENDPOINTS . 


## Resources

| Name                                     | Description                                                            | Type              |
|------------------------------------------|------------------------------------------------------------------------|-------------------|
| azurerm_mysql_flexible_server | Azure MYSQL flexible server         | azurerm           |
| azurerm_postgresql_flexible_server       | Azure POSTGRESQL flexible server                                                 | azurerm           |
| azurerm_mariadb_server                    | Azure mariadb server App.                                                   | azurerm           |
| azurerm_mysql_flexible_database | Azure MYSQL flexible server  database       | azurerm           |
| azurerm_postgresql_flexible_server_database       | Azure POSTGRESQL flexible server  database                                              | azurerm           |
| azurerm_mariadb_database                    | Azure mariadb database     |   azurerm           | 
| azurerm_private_dns_zone                    | Azure private dns zone     | azurerm           |
| azurerm_private_dns_zone_virtual_network_link                    | Azure  Private DNS zone Virtual Network Links.     |   azurerm           | 
| azurerm_private_endpoint                    | Azure private endpoint for mariadb server     | azurerm           |


### data source Variables

| Module Name       | Variable Name                                 | Type   | Description                                                                                        |
|-------------------|-----------------------------------------------|--------|----------------------------------------------------------------------------------------------------|
| locals               | project                                       | string | The name of the project.                                                                           |
| data.azurerm_resource_group | resource_group_name                           | string | The name of your resource group that is already .created .                                                       |
| "azurerm_virtual_network"  | vnet_name                                     | string | The Name of your virtual network where you want to create your database.                                                     |


### MySQL Flexible Server Configuration

| Variable Name                   | Description                                           | Example Value               |
| --------------------------------| ------------------------------------------------------| ----------------------------|
| create_mysql_fs                 | Set to `true` to create MySQL Flexible Server.       | `true`                      |
| mysql_fs_server_name            | Name for the MySQL Flexible Server.                   | `"my-mysql-server"`         |
| resource_group_name             | Name of the Azure resource group.                     | `"my-resource-group"`       |
| location                        | Azure region for deployment.                          | `"East US"`                 |
| administrator_login             | Administrator login for MySQL Server.                 | `"myadmin"`                 |
| administrator_password          | Administrator password for MySQL Server.             | `"MyP@ssw0rd123"`           |
| mysql_sku_name                  | SKU name for the MySQL Flexible Server.              | `"GP_Gen5_2"`               |
| backup_retention_days           | Number of days to retain backups.                    | `7`                         |
| create_mode                     | MySQL Server creation mode.                          | `"Default"`                 |
| auto_grow_enabled               | Enable auto-grow for storage.                        | `true`                      |
| iops                            | Input/Output Operations Per Second (IOPS) for storage. | `1000`                     |
| storagesize_gb                  | Size of storage in gigabytes.                       | `64`                        |
| geo_redundant_backup_enabled    | Enable geo-redundant backups.                        | `true`                      |
| zone                            | Azure Availability Zone for deployment.              | `1`                         |

### MySQL Database Configuration

| Variable Name                   | Description                                           | Example Value               |
| --------------------------------| ------------------------------------------------------| ----------------------------|
| create_mysql_fs                 | Set to `true` to create MySQL Database.               | `true`                      |
| db_names                        | Name for the MySQL Database.                         | `"my-database"`             |
| mysql_fs_db_charset             | Charset for the MySQL Database.                      | `"utf8mb4"`                 |
| mysql_fs_db_collation           | Collation for the MySQL Database.                    | `"utf8mb4_unicode_ci"`      |

Note: Please refer to the module documentation for additional optional variables and their descriptions.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server

### PostgreSQL Flexible Server Configuration

| Variable Name                   | Description                                           | Example Value               |
| --------------------------------| ------------------------------------------------------| ----------------------------|
| create_postgresql_fs            | Set to `true` to create PostgreSQL Flexible Server.  | `true`                      |
| fs_server_name                  | Name for the PostgreSQL Flexible Server.              | `"my-postgresql-server"`    |
| resource_group_name             | Name of the Azure resource group.                     | `"my-resource-group"`       |
| location                        | Azure region for deployment.                          | `"East US"`                 |
| fs_server_version               | Version of PostgreSQL Server.                         | `"11"`                      |
| administrator_login             | Administrator login for PostgreSQL Server.            | `"myadmin"`                 |
| administrator_password          | Administrator password for PostgreSQL Server.        | `"MyP@ssw0rd123"`           |
| fs_storage_mb                   | Storage size in megabytes.                           | `51200`                     |
| fs_sku_name                     | SKU name for PostgreSQL Flexible Server.             | `"Standard_D2s_v3"`         |
| backup_retention_days           | Number of days to retain backups.                    | `7`                         |
| create_mode                     | PostgreSQL Server creation mode.                     | `"Default"`                 |
| high_availability_mode          | High availability mode for PostgreSQL Server.         | `"Enable"`                  |

### PostgreSQL Database Configuration

| Variable Name                   | Description                                           | Example Value               |
| --------------------------------| ------------------------------------------------------| ----------------------------|
| create_postgresql_fs            | Set to `true` to create PostgreSQL Database.          | `true`                      |
| fs_db_names                     | Name for the PostgreSQL Database.                     | `"my-database"`             |
| fs_db_collation                 | Collation for the PostgreSQL Database.               | `"en_US.UTF-8"`             |
| fs_db_charset                   | Charset for the PostgreSQL Database.                 | `"UTF8"`                    


Note: Please refer to the module documentation for additional optional variables and their descriptions.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server

### Private Endpoint Configuration

| Variable Name                   | Description                                           | Example Value                |
| --------------------------------| ------------------------------------------------------| -----------------------------|
| create_mariadb                  | Set to `true` to create MariaDB resources.            | `true`                       |
| server-name                     | Name for the MariaDB server.                          | `"my-mariadb-server"`        |
| location                        | Azure region for deployment.                          | `"East US"`                  |
| resource_group_name             | Name of the Azure resource group.                     | `"my-resource-group"`        |
| private_service_connection_name  | Name for the private service connection.              | `"my-private-connection"`    |
| private_service_connection_is_manual_connection | Set to `true` for manual connection.     | `true`              |
| private_service_connection_subresource_names | List of subresource names for the connection. | `["db", "admin"]`     |

### MariaDB Server Configuration

| Variable Name                   | Description                                           | Example Value                |
| --------------------------------| ------------------------------------------------------| -----------------------------|
| mariadb_sku                     | SKU name for MariaDB server.                         | `"GP_Gen5_2"`                |
| mariadb_version                 | Version of MariaDB Server.                          | `"10.3"`                     |
| mariadb_storage_mb              | Storage size in megabytes.                          | `51200`                      |
| administrator_login             | Administrator login for MariaDB Server.             | `"myadmin"`                  |
| administrator_password          | Administrator password for MariaDB Server.         | `"MyP@ssw0rd123"`            |
| auto_grow_enabled               | Set to `true` to enable auto-grow.                  | `true`                       |
| backup_retention_days           | Number of days to retain backups.                   | `7`                          |
| mariadb_geo_redundant_backup_enabled | Enable geo-redundant backups.                    | `true`                       |
| public_network_access_enabled    | Set to `true` to enable public network access.      | `true`                       |
| ssl_enforcement_enabled         | Enable SSL enforcement.                             | `true`                       |
| ssl_minimal_tls_version_enforced | Minimal TLS version for SSL enforcement.            | `"TLS1_2"`                   |

### MariaDB Database Configuration

| Variable Name                   | Description                                           | Example Value                |
| --------------------------------| ------------------------------------------------------| -----------------------------|
| create_mariadb_database         | Set to `true` to create MariaDB Database.           | `true`                       |
| db-name                         | Name for the MariaDB Database.                      | `"my-database"`              |
| databases_charset               | Charset for the MariaDB Database.                   | `"UTF8"`                     |
| databases_collation             | Collation for the MariaDB Database.                 | `"en_US.UTF-8"`              |

Note: Please refer to the module documentation for additional optional variables and their descriptions.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources

### Outputs

| Output Name   | Description                            |
|---------------|----------------------------------------|
| postgresql_fqdn | Fully Qualified Domain Name (FQDN) for the PostgreSQL server. |
| mysql_fqdn    | Fully Qualified Domain Name (FQDN) for the MySQL server.      |
| mariadb_fqdn  | Fully Qualified Domain Name (FQDN) for the MariaDB server.    |


Note: Please refer to the module documentation for additional optional variables and their descriptions.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_server

## Note

Make sure to provide the necessary values for the input variables and adjust the module accordingly.

Please refer to the documentation of each individual resource for more details on their usage and specific input variables.


## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-azure-databases/blob/main/LICENSE) for full details.