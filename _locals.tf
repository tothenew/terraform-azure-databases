locals {
  project_name_prefix = var.project_name_prefix == "" ? terraform.workspace : var.project_name_prefix
  common_tags         = length(var.common_tags) == 0 ? var.default_tags : merge(var.default_tags, var.common_tags)
}