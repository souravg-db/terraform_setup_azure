terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    databricks = {
      source = "databricks/databricks"
      version = "~> 1.24.0"
    }
  }
   backend "azurerm" {
      subscription_id = "3f2e4d32-8e8d-46d6-82bc-5bb8d962328b"
      resource_group_name  = "sgunity"
      storage_account_name = "testunity0823dev"
      container_name       = "terraform1"
      key                  = "terraform.tfstateenv"
  }
}