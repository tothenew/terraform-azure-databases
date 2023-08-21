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


### Input Variables

| Module Name       | Variable Name                                 | Type   | Description                                                                                        |
|-------------------|-----------------------------------------------|--------|----------------------------------------------------------------------------------------------------|
| locals               | project                                       | string | The name of the project.                                                                           |
| data.azurerm_resource_group | resource_group_name                           | string | The name of your resource group that is already .created .                                                       |
| "azurerm_virtual_network"  | vnet_name                                     | string | The Name of your virtual network where you want to create your database.                                                     |
| module.mysql       | subnet_name                                   | string | The name of the subnet for the MySQL database.                                                     |
| module.mysql       | dns_zone_virtual_network_link_name            | string | The name of the DNS zone virtual network link.                                                     |
| module.mysql       | create_mysql_fs                               | bool   | A flag to indicate whether to create the MySQL file server.                                        |
| module.mysql       | administrator_login                           | string | The administrator login for the MySQL database.                                                    |
| module.mysql       | administrator_password                        | string | The administrator password for the MySQL database.                                                 |
| module.mysql       | db_names                                      | list   | The list of database names for the MySQL database.                                                 |
| module.mysql       | backup_retention_days                         | number | The number of days to retain backups for the MySQL database.                                       |
| module.mysql       | create_mode                                   | string | The creation mode for the MySQL database.                                                          |
| module.mysql       | private_dns_zone_mysql_fs_name                | string | The name of the private DNS zone for the MySQL flexible server.                                        |
| module.mysql       | mysql_fs_server_name                          | string | The name of the MySQL flexible server.                                                                 |
| module.mysql       | auto_grow_enabled                             | bool   | A flag to indicate whether auto-grow is enabled for the MySQL database.                            |
| module.mysql       | iops                                          | number | The number of IOPS for the MySQL database.                                                         |
| module.mysql       | mysql_sku_name                                | string | The SKU name for MySQL.                                                                            |
| module.mysql       | storagesize_gb                                | number | The storage size in GB for the MySQL database.                                                     |
| module.mysql       | geo_redundant_backup_enabled                  | bool   | A flag to indicate whether geo-redundant backup is enabled for the MySQL database.                 |
| module.mysql       | zone                                          | string | The availability zone for the MySQL database.                                                      |
| module.mysql       | mysql_fs_db_charset                           | string | The charset for the MySQL flexible server database.                                                    |
| module.mysql       | mysql_fs_db_collation                         | string | The collation for the MySQL flexible server database.                                                  |
| module.mysql       | firewall_rule_name                            | string | The name of the firewall rule for the MySQL database.                                             |
| module.mysql       | start_ip                                      | string | The start IP address for the firewall rule for the MySQL database.                                 |
| module.mysql       | end_ip                                        | string | The end IP address for the firewall rule for the MySQL database.                                   |
| module.mysql       | server_configuration_name                     | string | The name of the server configuration for the MySQL database.                                      |
| module.mysql       | value                                         | string | The value for the server configuration for the MySQL database.                                    |
| module.Postgresql  | create_postgresql_fs                          | bool   | A flag to indicate whether to create the PostgreSQL flexible server.                                   |
| module.Postgresql  | administrator_login                           | string | The administrator login for the PostgreSQL database.                                               |
| module.Postgresql  | administrator_password                        | string | The administrator password for the PostgreSQL database.                                            |
| module.Postgresql  | backup_retention_days                         | number | The number of days to retain backups for the PostgreSQL database.                                  |
| module.Postgresql  | create_mode                                   | string | The creation mode for the PostgreSQL database.                                                     |
| module.Postgresql  | high_availability_mode                        | string | The high availability mode for the PostgreSQL database.                                            |
| module.Postgresql  | private_dns_zone_postgresql_fs_name           | string | The name of the private DNS zone for the PostgreSQL flexible server.                                   |
| module.Postgresql  | fs_server_name                                | string | The name of the PostgreSQL flexible server.                                                            |
| module.Postgresql  | fs_server_version                             | string | The version of the PostgreSQL flexible server.                                                         |
| module.Postgresql  | fs_storage_mb                                 | number | The storage size in MB for the PostgreSQL database.                                                |
| module.Postgresql  | fs_sku_name                                   | string | The SKU name for the PostgreSQL flexible server.                                                       |
| module.Postgresql  | fs_db_names                                   | list   | The list of database names for the PostgreSQL database.                                            |
| module.Postgresql  | fs_db_collation                               | string | The collation for the PostgreSQL flexible server database.                                             |
| module.Postgresql  | fs_db_charset                                 | string | The charset for the PostgreSQL flexible server database.                                               |
| module.mariadb     | create_mariadb                                | bool   | A flag to indicate whether to create the MariaDB database.                                         |
| module.mariadb     | mariadb_sku                                   | string | The SKU for MariaDB.                                                                               |
| module.mariadb     | mariadb_storage_mb                            | number | The storage size in MB for MariaDB.                                                                 |
| module.mariadb     | mariadb_version                               | string | The version of MariaDB.                                                                            |
| module.mariadb     | private_endpoint_network_policies_enabled    | bool   | A flag to indicate whether private endpoint network policies are enabled for MariaDB.             |
| module.mariadb     | private_service_connection_name              | string | The name of the private service connection for MariaDB.                                           |
| module.mariadb     | private_service_connection_is_manual_connection | bool | A flag to indicate whether the private service connection for MariaDB is manual.                   |
| module.mariadb     | private_service_connection_subresource_names | list   | The list of subresource names for the private service connection for MariaDB.                      |
| module.mariadb     | private_dns_zone_name    | string | The name of the private DNS zone for MariaDB.                                                      |
| module.mariadb     | server-name                                   | string | The name of the MariaDB server.                                                                    |
| module.mariadb     | administrator_login                           | string | The administrator login for MariaDB.                                                               |
| module.mariadb     | administrator_password                        | string | The administrator password for MariaDB.                                                            |
| module.mariadb     | auto_grow_enabled                             | bool   | A flag to indicate whether auto-grow is enabled for MariaDB.                                       |
| module.mariadb     | backup_retention_days                         | number | The number of days to retain backups for MariaDB.                                                  |
| module.mariadb     | mariadb_geo_redundant_backup_enabled          | bool   | A flag to indicate whether geo-redundant backup is enabled for MariaDB.                           |
| module.mariadb     | public_network_access_enabled                 | bool   | A flag to indicate whether public network access is enabled for MariaDB.                          |
| module.mariadb     | ssl_enforcement_enabled                       | bool   | A flag to indicate whether SSL enforcement is enabled for MariaDB.                                 |
| module.mariadb     | ssl_minimal_tls_version_enforced              | string | The minimal TLS version enforced for MariaDB.                                                      |
| module.mariadb     | db-name                                       | string | The name of the database for MariaDB.                                                              |
| module.mariadb     | databases_charset                             | string | The charset for the databases in MariaDB.                                                          |
| module.mariadb     | databases_collation                           | string | The collation for the databases in MariaDB.                                                        |


Note: Please refer to the module documentation for additional optional variables and their descriptions.

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources

### Outputs

| Output Name   | Description                            |
|---------------|----------------------------------------|
| postgresql_fqdn | Fully Qualified Domain Name (FQDN) for the PostgreSQL server. |
| mysql_fqdn    | Fully Qualified Domain Name (FQDN) for the MySQL server.      |
| mariadb_fqdn  | Fully Qualified Domain Name (FQDN) for the MariaDB server.    |


## Note

Make sure to provide the necessary values for the input variables and adjust the module source paths accordingly.

Please refer to the documentation of each individual module for more details on their usage and specific input variables.


## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-azure-databases/blob/main/LICENSE) for full details.