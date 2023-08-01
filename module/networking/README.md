# Terraform Azure Virtual Network module

This Terraform module creates an Azure Virtual Network with a subnet for container apps.

## Usage

```terraform
module "vnet" {
  source            = "./modules/vnet"
  name              = "vnet01"
  location          = "eastus"
  resource_group    = "my-resource-group"
  vnetcidr          = "10.0.0.0/16"
  websubnetcidr     = "10.0.1.0/24"
}
```

## Inputs

| Name           | Description                                  | Type   | Default | Required |
|----------------|----------------------------------------------|--------|---------|----------|
| `name`         | The name of the virtual network              | string | n/a     | yes      |
| `location`     | The Azure region to create the resources in   | string | n/a     | yes      |
| `resource_group` | The name of the resource group to create the resources in | string | n/a | yes |
| `vnetcidr`     | The IP address range for the virtual network | string | n/a     | yes      |
| `websubnetcidr` | The IP address range for the container apps subnet | string | n/a | yes |

## Outputs

| Name                | Description                                          |
|---------------------|------------------------------------------------------|
| `vnet_id`           | The ID of the virtual network                         |
| `websubnet_id`      | The ID of the subnet for container apps                |
| `websubnet_address` | The address prefix of the subnet for container apps   |

## Resources Created

This module creates the following resources:

- `azurerm_virtual_network.vnet01`: The Azure virtual network
- `azurerm_subnet.web-subnet`: The subnet for container apps

For more information on these resources and their configuration options, see the [Azure Terraform Provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) and [subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) resources.

## Author
 Gaurav
