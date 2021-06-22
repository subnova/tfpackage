variable "env" {
  type = string
  description = "The environment that the application is being deployed into"
}

variable "rg_name" {
  type = string
  description = "The name of the resource group that will be used"
}

variable "rg_location" {
  type = string
  description = "The location of the resource group"
}

variable "acr_name" {
  type = string
  description = "The name of the Azure Container Registry to use for storing the image"
}
