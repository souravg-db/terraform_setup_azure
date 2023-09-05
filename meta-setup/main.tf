#Setup local vars

locals {
  azure_meta_subscription        = var.azure_meta_subscription
  databricks_account_id     = var.databricks_account_id
  meta_storage_account      = var.meta_storage_account
  access_connector_rg = var.access_connector_rg
  access_connector_name = var.access_connector_name
  meta_storage_account_rg = var.meta_storage_account_rg
  metastore_owner = var.metastore_owner
  metastore_region = var.metastore_region
  unity_metastore_name  = var.unity_metastore_name
  meta_storage_account_container = var.meta_storage_account_container
  access_connector_exist = var.access_connector_exist
  existing_access_connector_id = var.existing_access_connector_id
    
}

### Setup required provider info

#  Provider for azure 
provider "azurerm" {
  alias = "meta"
  subscription_id = local.azure_meta_subscription
  features {}
}


#  Provider for databricks account
provider "databricks" {
  alias      = "account"
  host = "https://accounts.azuredatabricks.net/"
  auth_type  = "azure-cli"
  account_id = local.databricks_account_id
}


// Create/Use Existing azure managed identity to be used by unity catalog metastore

module "access_connector" {
  count = local.access_connector_exist ? 0 : 1
  source = "../modules/access_connector"
  access_connector_name   = local.access_connector_name
  azure_resource_group = local.access_connector_rg
  providers = {
    azurerm = azurerm.meta
  }
}

// Provide required role to access connector on meta storage account if created using terraform
module "access_connector_role_assignment" {
  count = local.access_connector_exist ? 0 : 1
  source = "../modules/access_connector_role_assignment"
  access_connector_name     = local.access_connector_name
  principal_id = module.access_connector[0].access_connector_principal_id
  storage_account_name      = local.meta_storage_account
  azure_resource_group      = local.meta_storage_account_rg 
  providers = {
    azurerm = azurerm.meta
  }
    depends_on = [
    module.access_connector
  ]
}

// Create Unity metastore and default storage cred
module "create_metastore" {
  source = "../modules/metastore_and_users"
  unity_metastore_name        = local.unity_metastore_name
  meta_storage_account      = local.meta_storage_account
  container_name = local.meta_storage_account_container
  azure_resource_group = local.meta_storage_account_rg
  owner = local.metastore_owner
  access_connector_id = var.access_connector_exist ? local.existing_access_connector_id : module.access_connector[0].access_connector_id
  region = local.metastore_region
  providers = {
    databricks = databricks.account,
    azurerm = azurerm.meta
  }
  depends_on = [
    module.access_connector,
    module.access_connector_role_assignment
  ]
}
