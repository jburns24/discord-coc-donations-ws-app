resource "azurerm_service_plan" "coc_donations_app_service_plan" {
  name                = "coc-donations-app-service-plan"
  resource_group_name = azurerm_resource_group.coc_donations_rg.name
  location            = azurerm_resource_group.coc_donations_rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "coc_donations_app_service" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.coc_donations_rg.name
  location            = azurerm_resource_group.coc_donations_rg.location
  service_plan_id     = azurerm_service_plan.coc_donations_app_service_plan.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    always_on = false # This has to be disabled for the free tier
    application_stack {
      docker_image_name   = "coc-disco-donations:latest"
      docker_registry_url = "https://ghcr.io/jburns24/discord-coc-donations-ws-app"
    }
  }
}
