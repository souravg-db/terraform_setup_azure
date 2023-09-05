variable "azure_subscription" {
  description = "The Azure resource ID for the databricks workspace deployment. This is where unity catalog will be deployed"
}

variable "azure_resource_group" {
  description = "The Azure resource ID for the databricks workspace deployment. This is where unity catalog will be deployed"
}
variable "metastore_id" {
  description = "Azure databricks account id"
}

variable "databricks_workspace" {
  description = "Azure databricks access connector"
}