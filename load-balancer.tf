# Public IP for Load Balancer
resource "azurerm_public_ip" "lb_pip" {
  name                = "lb-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"

  zones = ["1", "2", "3"]
}

# Load Balancer
resource "azurerm_lb" "lb" {
  name                = "clco-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku = "Standard"

  frontend_ip_configuration {
    name                 = "lb-frontend"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

# Backend Pool
resource "azurerm_lb_backend_address_pool" "bepool" {
  name            = "lb-backendpool"
  loadbalancer_id = azurerm_lb.lb.id
}

# Associate NICs with backend pool
resource "azurerm_network_interface_backend_address_pool_association" "vm1_lb_assoc" {
  network_interface_id    = azurerm_network_interface.vm1_nic.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "vm2_lb_assoc" {
  network_interface_id    = azurerm_network_interface.vm2_nic.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
}

# Health Probe
resource "azurerm_lb_probe" "probe" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.lb.id
  port            = 80
  protocol        = "Http"

  request_path = "/"
}

# LB Rule (port 80 → 80)
resource "azurerm_lb_rule" "lbrule" {
  name            = "http-rule"
  loadbalancer_id = azurerm_lb.lb.id

  frontend_ip_configuration_name = "lb-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool.id]

  protocol      = "Tcp"
  frontend_port = 80
  backend_port  = 80

  probe_id = azurerm_lb_probe.probe.id
}
