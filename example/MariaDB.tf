module "create_database" {
  source                                   = "git::https://github.com/tothenew/terraform-azure-databases.git?ref=database-v1"
  environment                              = "dev"
  project                                  = "azure"
  
  create_mariadb                           = true

  resource_group_name                      = "database-rg"
  location                                 = "EAST US 2" 
  vnet-name                                = "myvnet"
  vnetcidr                                 = "10.0.0.0/16"
  subnet_name                              = "db-subnet"
  address_prefixes                         = ["10.0.3.0/28"]
  
}