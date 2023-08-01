module "create_database" {
  source                                   = "git::https://github.com/tothenew/terraform-azure-databases.git"
  
  environment                              = "dev"
  project                                  = "azure"
  
  create_mysql_fs                          = true

  resource_group_name                      = "database-rg"
  location                                 = "EAST US 2" 
  vnet-name                                = "myvnet"
  vnetcidr                                 = "10.0.0.0/16"
  subnet_name                              = "db-subnet"
  address_prefixes                         = ["10.0.4.0/28"]
}

