variable "resource_group" {}

variable "location" {}

variable "vnetcidr" {}

variable "project" {
  description = "The name of the project associated with the resources. It helps in organizing and categorizing resources."
  type        = string
}

variable "environment" {
  description = "The environment where the resources will be deployed, such as development, staging, or production."
  type        = string
}

variable "vnet-name" {
  description = "name of the virtual network"
  type = string

}