#Setup local vars

locals {
  azure_env_subscription        = var.azure_env_subscription
  azure_workspace_for_deployment = var.azure_workspace_for_deployment
  azure_workspaces_for_assignment = var.azure_workspaces_for_assignment
  metastore_owner = var.metastore_owner
  azure_workspace_for_deployment_rg = var.azure_workspace_for_deployment_rg
  existing_access_connector_id = var.existing_access_connector_id
  unity_metastore_id =var.unity_metastore_id 
  current_env = var.current_env 
  external_locations = var.external_locations
}

### Setup required data and provider info

#  Provider for azure 
provider "azurerm" {
  alias = "env"
  subscription_id = local.azure_env_subscription
  features {}
}

data "azurerm_databricks_workspace" "dep_workspace" {
  provider = azurerm.env
  name                = local.azure_workspace_for_deployment
  resource_group_name = local.azure_workspace_for_deployment_rg
}

locals {
  databricks_workspace_host = data.azurerm_databricks_workspace.dep_workspace.workspace_url
  databricks_workspace_id   = data.azurerm_databricks_workspace.dep_workspace.workspace_id
}

provider "databricks" {
  alias      = "workspace"
  host       = local.databricks_workspace_host
  # profile = "ACCOUNT"
  auth_type  = "azure-cli"
}

##### Assign workspaces to metastore

module "workspace_assignment" {
  source = "../modules/workspace_assignment"
  for_each = toset(local.azure_workspaces_for_assignment)
  azure_subscription        = local.azure_env_subscription
  metastore_id              = local.unity_metastore_id
  databricks_workspace      = "${element(split(":", each.key),0)}"
  azure_resource_group      = "${element(split(":", each.key),1)}"
  providers = {
    databricks = databricks.workspace,
    azurerm = azurerm.env
  }
}


// Storage credential creation to be used to create external location
resource "databricks_storage_credential" "external_mi" {
  provider = databricks.workspace
  name = format("%s_%s",local.current_env,"external_location_mi_credential")
  azure_managed_identity {
    access_connector_id = local.existing_access_connector_id
  }
  owner      = local.metastore_owner
  comment    = "Storage credential for all external locations"
  depends_on = [module.workspace_assignment]
}


// Create required external locations
module "create_external_location" {
  source = "../modules/create-external-location"
  for_each = toset(local.external_locations)
  external_location_name        = "${element(split(":", each.key),0)}"
  container_name      = "${element(split(":", each.key),1)}"
  storage_account_name              = "${element(split(":", each.key),2)}"
  storage_credential_id      = databricks_storage_credential.external_mi.id
  owner = local.metastore_owner
  providers = {
    databricks = databricks.workspace,
  }
}
