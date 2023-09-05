locals {
  external_location_name        = var.external_location_name
  container_name      = var.container_name
  storage_account_name              = var.storage_account_name
  storage_credential_id      = var.storage_credential_id
  owner = var.owner
}

// Create external location 
resource "databricks_external_location" "ext_location" {
  provider = databricks
  name = local.external_location_name
  url = format("abfss://%s@%s.dfs.core.windows.net",
    local.container_name,local.storage_account_name)
  credential_name = local.storage_credential_id
  owner           = local.owner
  comment         = "External location "
}