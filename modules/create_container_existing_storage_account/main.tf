#  Create a container in storage account to be used by unity catalog metastore as root storage
locals {
  name        = var.name
  storage_account_name      = var.storage_account_name
}
resource "azurerm_storage_container" "unity_catalog" {
  name                  = local.name
  storage_account_name  = local.storage_account_name
  container_access_type = "private"
}