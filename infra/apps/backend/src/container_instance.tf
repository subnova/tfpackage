resource "null_resource" "push_backend" {
  triggers = {
    always_runs = timestamp()
  }

  provisioner "local-exec" {
    command = "./push.sh ${var.local_image_name} ${var.remote_image_name} ${data.azurerm_container_registry.registry.login_server}"
  }
}

data "external" "container_image" {
  program = ["./image_id.sh"]
  depends_on = [null_resource.push_backend]
  query = {
    acr_login_server: data.azurerm_container_registry.registry.login_server
    remote_image_name: var.remote_image_name
  }
}

resource "azurerm_container_group" "backend" {
  name = "dpeakallbackend-${var.env}"
  location = var.rg_location
  resource_group_name = var.rg_name
  ip_address_type = "Public"
  dns_name_label = "dpeakallbackend${var.env}"
  os_type = "Linux"

  image_registry_credential {
    password = azuread_service_principal_password.backend.value
    server = data.azurerm_container_registry.registry.login_server
    username = azuread_service_principal.backend.application_id
  }

  container {
    name = "server"
    cpu = 0.5
    image = data.external.container_image.result.image
    memory = 1.5

    ports {
      port = "80"
      protocol = "TCP"
    }
  }
}
