locals {
  access_connector_name        = var.access_connector_name
  azure_resource_group      = var.azure_resource_group
}

data "azurerm_resource_group" "azure_rg" {
  name = local.azure_resource_group
}

resource "azurerm_databricks_access_connector" "unity" {
  name                = local.access_connector_name
  resource_group_name = data.azurerm_resource_group.azure_rg.name
  location            = data.azurerm_resource_group.azure_rg.location
  identity {
    type = "SystemAssigned"
  }
}


