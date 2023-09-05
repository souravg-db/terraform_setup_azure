variable "access_connector_name" {
  description = "Name od access connector"
}

variable "azure_resource_group" {
  description = "The Azure resource ID for the databricks workspace deployment. This is where unity catalog will be deployed"
}
variable "storage_account_name" {
  description = "Name of storage account on which access connector will be granted access"
}

variable "principal_id" {
  description = "Principal id of access connector"
}