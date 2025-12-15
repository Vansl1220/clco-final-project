resource "azurerm_cognitive_account" "lang" {
  name                = "lang-${var.resource_group_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  kind     = "TextAnalytics"
  sku_name = "S"

  # Allow public access for sentiment analysis
  public_network_access_enabled = true

  custom_subdomain_name = "lang-${var.resource_group_name}"

  tags = {
    project = "clco"
  }
}
