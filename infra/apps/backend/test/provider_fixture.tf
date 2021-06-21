terraform {
  required_version = "1.0.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.64.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "env" {
  type = string
}

resource "azurerm_resource_group" "rg" {
  display_name = "dpeakall-demo-${var.env}"
  location = "UK South"
  tags = {
    env = var.env
    rg = "demo"
  }
}

resource "azurerm_container_registry" "acr" {
  name = "dpeakalldemo${var.env}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku = "Basic"
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_location" {
  value = azurerm_resource_group.rg.location
}