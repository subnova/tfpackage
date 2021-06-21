variable "rg_name" {
  type = string
  description = "The name of the resource group that will be used"
}

variable "rg_location" {
  type = string
  description = "The location of the resource group"
}

variable "acr_login_server" {
  type = string
  description = "The login server for Azure Container Registry containing the image"
}

variable "env" {
  type = string
  description = "The environment that the application is being deployed into"
}