# resource "azurerm_container_registry" "acr" {
#     name                     = "coc-disco-donations-acr"
#     resource_group_name      = azurerm_resource_group.coc_donations_rg.name
#     location                 = azurerm_resource_group.coc_donations_rg.location
#     sku                      = "Basic"
#     admin_enabled            = false
#     # georeplication_locations = ["eastus", "westus"]
# }
