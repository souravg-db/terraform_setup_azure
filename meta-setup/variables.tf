# The Azure resource ID for the Databricks workspace where Unity Catalog will be deployed. It should be of the format /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Databricks/workspaces/workspace1. To find the resource ID, navigate to your Databricks workspace in the Azure portal, select the JSON View link on the Overview page.
variable "azure_meta_subscription" {
  description = "Subscription of azure storage which is default storage for unity metastore"
}

variable "databricks_account_id" {
  description = "Azure databricks account id"
}

variable "access_connector_name" {
  description = "Azure databricks access connector"
}

variable "meta_storage_account" {
  description = "Azure storage account for unity metastore"
}

variable "meta_storage_account_container" {
  description = "Azure storage container for unity metastore"
}

variable "unity_metastore_name" {
  description = "Unity metatotore name"
}

variable "metastore_owner" {
  description = "Owner of the unity metastore"
}

variable "metastore_region" {
  description = "Region of metastore"
}

variable "access_connector_exist" {
  description = "Boolean variable to check if access connector exists"
  type = bool
}
variable "meta_storage_account_rg" {
  description = "Resource group of unity meta storage account"
}

variable "access_connector_rg" {
  description = "Resource group of unity access connector"
}
variable "existing_access_connector_id" {
  description = "Id of access connector if already existing"
}

