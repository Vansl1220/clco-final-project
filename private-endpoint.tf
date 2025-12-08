//Private Endpoint for Cognitive services
resource "azurerm_private_endpoint" "cog_pe" {
  name                = "cognitive-pe"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.ai.id
//defines Azure resource we connect privately to
  private_service_connection {
    name                           = "cognitive-connection"
    private_connection_resource_id = azurerm_cognitive_account.lang.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "cog-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.cog_dns.id]
  }
}
