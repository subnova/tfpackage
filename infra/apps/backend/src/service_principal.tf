resource "azuread_application" "backend" {
  display_name = "dpeakall-demo-${var.env}"
  owners = [
    data.azuread_client_config.current.object_id
  ]
}

resource "azuread_service_principal" "backend" {
  application_id = azuread_application.backend.application_id
  tags = []
}

resource "azuread_service_principal_password" "backend" {
  service_principal_id = azuread_service_principal.backend.id
  end_date_relative = "17520h" # expires in 2 years
}

resource "azurerm_role_assignment" "backend_contributor" {
  scope = data.azurerm_subscription.main.id
  role_definition_name = "Contributor"
  principal_id = azuread_service_principal.backend.id
}

resource "azurerm_role_assignment" "backend_acrpull" {
  scope = data.azurerm_container_registry.registry.id
  role_definition_name = "AcrPull"
  principal_id = azuread_service_principal.backend.id
}