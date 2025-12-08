resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-clco-project"
  address_space       = ["10.0.0.0/16"] // creats one big network
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
