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

variable "discord_token" {
  description = "The Discord token for the app service"
  type        = string
}

variable "clash_token" {
  description = "The Clash token for the app service"
  type        = string

}
