variable "unity_metastore_name" {
  description = "Name of the metastore"
}

variable "meta_storage_account" {
  description = "Storage root of the unity metastore"
}
variable "container_name" {
  description = "Name of the storage container"
}

variable "azure_resource_group" {
  description = "Name of the storage container"
}

variable "owner" {
  description = "Owner of unity metatore"
}

variable "access_connector_id" {
  description = "Access connector id for assigning to metastore"
}

variable "region" {
  description = "Region of metastore"
}