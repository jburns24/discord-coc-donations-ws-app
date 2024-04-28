resource "azurerm_resource_group" "coc_donations_rg" {
  name     = var.resource_group_name
  location = var.location
}
