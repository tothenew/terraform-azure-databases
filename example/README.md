# terraform-azure-databases 

This module sets up different types of databases in Azure, including 
- MYSQL flexible server 
- PostgreSQL flexible server
- MariaDB server

## Prerequisites

Before you begin, ensure you have the following requirements met:

1. Install Terraform (>= 1.3.0). You can download the latest version of Terraform from the official website: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

2. Azure CLI installed and configured with appropriate access rights. You can install the Azure CLI from [https://docs.microsoft.com/en-us/cli/azure/install-azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)


### Input Variables

Supports the following input variables:

- `create_mysql_fs`: (Required) set the value as true if you want to create mysql flexible server.
- `create_postgresql_fs`: (Required) set the value as true if you want to create postgresql flexible server.
- `create_mariadb`: (Required) set the value as true if you want to create mariadb server.

- `name`: (Required) The name of the resource group.
- `location`: (Required) The location/region where the your vnet is.
- `vnet_name`: (Required) The name of your vnet which should be already created.
- `subnet_name`: (Required) The name of your subnet .
- `address_prefixes`: (Required) address prefixes for your subnet.


