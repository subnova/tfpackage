terraform {
  required_version = "1.0.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.64.0"
    }

    azuread = {
      source = "hashicorp/azuread"
      version = "=1.5.1"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}