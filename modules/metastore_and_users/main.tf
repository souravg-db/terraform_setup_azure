

locals {
  unity_metastore_name        = var.unity_metastore_name
  meta_storage_account      = var.meta_storage_account
  container_name = var.container_name
  azure_resource_group = var.azure_resource_group
  owner = var.owner
  access_connector_id = var.access_connector_id
  region = var.region
}
data "azurerm_resource_group" "azure_rg" {
  name = local.azure_resource_group
}

data "azurerm_storage_account" "unity_meta_storage_account" {
  name                = local.meta_storage_account
  resource_group_name = data.azurerm_resource_group.azure_rg.name
}
#  Create unity catalog metastore
resource "databricks_metastore" "unity_metastore" {
  # provider  = databricks.workspace
  name = local.unity_metastore_name
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
  local.container_name,
  data.azurerm_storage_account.unity_meta_storage_account.name)
  force_destroy = true
  owner         = local.owner
  region = local.region
  delta_sharing_scope  = "INTERNAL_AND_EXTERNAL"
  delta_sharing_recipient_token_lifetime_in_seconds = "86400"
}

#  Assign managed identity to metastore
resource "databricks_metastore_data_access" "meta_storage_crd" {
  # provider  = databricks.workspace
  metastore_id = databricks_metastore.unity_metastore.id
  name         = "unity_storage_cred"
  azure_managed_identity {
    access_connector_id = local.access_connector_id
  }
  is_default = true
}