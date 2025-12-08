resource "azurerm_cognitive_account" "lang" {
  name                = "lang-${var.resource_group_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  kind     = "TextAnalytics"
  sku_name = "S0"

  #forces Azure to generate a private-only endpoint
  public_network_access_enabled = false
  
  tags = {
    project = "clco"
  }
}
