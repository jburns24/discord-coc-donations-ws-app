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
    "DISCORD_TOKEN"                       = var.discord_token
    "CLASH_TOKEN"                         = var.clash_token
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 1
        retention_in_mb   = 35
      }
    }
  }

  site_config {
    always_on = false # This has to be disabled for the free tier
    application_stack {
      docker_image_name   = var.image_name
      docker_registry_url = var.container_registry_url
    }
  }
}
