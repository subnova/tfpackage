data "azurerm_subscription" "main" {}
data "azuread_client_config" "current" {}
data "azurerm_container_registry" "registry" {
  name = var.acr_name
  resource_group_name = var.rg_name
}