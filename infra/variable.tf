variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location for the resource group"
  type        = string
}

variable "app_name" {
  description = "The name of the app service"
  type        = string
}

variable "secret" {
  description = "value of the secret"
  type        = string
}
