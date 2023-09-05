# The Azure resource ID for the Databricks workspace where Unity Catalog will be deployed. It should be of the format /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Databricks/workspaces/workspace1. To find the resource ID, navigate to your Databricks workspace in the Azure portal, select the JSON View link on the Overview page.
variable "azure_env_subscription" {
  description = "Subscription of azure env i.e. dev/test/prod subscription"
}

variable "unity_metastore_id" {
  description = "Id of unity metastore"
}

variable "azure_workspace_for_deployment" {
  description = "Azure workspace for deployment to register databricks provider for workspace apis"
}
variable "azure_workspace_for_deployment_rg" {
  description = "The Azure resource group of deployment workspace"
}

variable "azure_workspaces_for_assignment" {
  description = "List of workspaces to be assigned to metastore"
  type = list(string)
}

variable "metastore_owner" {
  description = "Owner of the unity metastore"
}

variable "existing_access_connector_id" {
  description = "Id of access connector if already existing"
}
variable "current_env" {
  description = "Current Environment i.e dev/test/prod"
}

variable "external_locations" {
  description = "List of external_locations_to_be_created"
  type = list(string)
}


