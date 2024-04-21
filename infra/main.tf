# terraform {
#   backend "azurerm" {
#     resource_group_name  = "coc-disco-donations-azure-data"
#     storage_account_name = "${local.environment.state_storage_account}"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#   }
# }

# provider "azurerm" {
#   features {}
# }

resource "azurerm_resource_group" "coc_donations_rg" {
  name     = "coc-donations-rg"
  location = "West Europe"
}

resource "azurerm_service_plan" "coc_donations_app_service_plan" {
  name                = "coc-donations-app-service-plan"
  resource_group_name = azurerm_resource_group.coc_donations_rg.name
  location            = azurerm_resource_group.coc_donations_rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "coc_donations_app_service" {
  name                = "coc-donations-app-service"
  resource_group_name = azurerm_resource_group.coc_donations_rg.name
  location            = azurerm_service_plan.coc_donations_app_service_plan.location
  service_plan_id     = azurerm_service_plan.coc_donations_app_service_plan.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    always_on = false # This has to be disabled for the free tier
    application_stack {
      docker_image_name   = "coc-disco-donations:${var.docker_image_tag}"
      docker_registry_url = "https://index.docker.io"
    }
  }
}
