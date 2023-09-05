locals {
  access_connector_name        = var.access_connector_name
  azure_resource_group      = var.azure_resource_group
  storage_account_name              = var.storage_account_name
  principal_id = var.principal_id
}

data "azurerm_resource_group" "azure_rg" {
  name = local.azure_resource_group
}


data "azurerm_storage_account" "unity_meta_storage_account" {
  name                = local.storage_account_name
  resource_group_name = data.azurerm_resource_group.azure_rg.name
}



# Assign the Storage Blob Data Contributor role to managed identity to allow unity catalog to access the storage
resource "azurerm_role_assignment" "unity_data_contributor_meta_storage" {
  scope                = data.azurerm_storage_account.unity_meta_storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = local.principal_id
}