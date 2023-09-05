locals {
  azure_subscription        = var.azure_subscription
  azure_resource_group      = var.azure_resource_group
  metastore_id              = var.metastore_id
  databricks_workspace      = var.databricks_workspace
}

data "azurerm_databricks_workspace" "dep_workspace" {
  name                = local.databricks_workspace
  resource_group_name = local.azure_resource_group
}

locals {
  databricks_workspace_host = data.azurerm_databricks_workspace.dep_workspace.workspace_url
  databricks_workspace_id   = data.azurerm_databricks_workspace.dep_workspace.workspace_id
}

resource "databricks_metastore_assignment" "meta_assignment" {
  # provider  = databricks.workspace
  workspace_id         = local.databricks_workspace_id
  metastore_id         = local.metastore_id
  default_catalog_name = "hive_metastore"
}