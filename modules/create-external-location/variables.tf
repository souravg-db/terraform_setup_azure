variable "external_location_name" {
  description = "Name of external location"
}

variable "container_name" {
  description = "Container name to which external location points to"
}

variable "storage_account_name" {
  description = "Storage account name to which external location points to"
}

variable "storage_credential_id" {
  description = "Storage Credential name to access external location"
}

variable "owner" {
  description = "Owner of external location"
}