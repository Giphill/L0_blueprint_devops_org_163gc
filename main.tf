terraform {
  required_providers {
    azurerm = {
      # https://github.com/terraform-providers/terraform-provider-azurerm
      source  = "hashicorp/azurerm"
      version = "~> 3.9.0"
    }
    azuredevops = {
      # https://github.com/microsoft/terraform-provider-azuredevops
      source  = "microsoft/azuredevops"
      version = ">=0.2.1"
    }
  }
  required_version = ">= 1.2.6"
}

provider "azurerm" {
  features {}
}


data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}