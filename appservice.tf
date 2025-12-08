# App Service Plan (Linux, B1)
resource "azurerm_service_plan" "appplan" {
  name                = "appserviceplan-${var.resource_group_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type = "Linux"
  sku_name = "B1"
}

# App Service (Python Web App)
resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp-${var.resource_group_name}"
  location            = azurerm_service_plan.appplan.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appplan.id

  https_only = true

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"

    "AI_ENDPOINT" = azurerm_cognitive_account.lang.endpoint
    "AI_KEY"      = azurerm_cognitive_account.lang.primary_access_key
  }
}
