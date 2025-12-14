// Resource Group Name
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

//Web App URL
output "webapp_default_hostname" {
  description = "URL of the deployed web app"
  value       = azurerm_linux_web_app.webapp.default_hostname
}

//Congnitive Service AI
output "cognitive_endpoint" {
  description = "Endpoint of the Azure Language Service"
  value       = azurerm_cognitive_account.lang.endpoint
}

//VNet
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

//Load Balancer
output "load_balancer_public_ip" {
  description = "Public IP address of the Load Balancer for testing VM HA"
  value       = azurerm_public_ip.lb_pip.ip_address
}

//VM PRivate IP
output "vm1_private_ip" {
  description = "Private IP address of VM1"
  value       = azurerm_network_interface.vm1_nic.private_ip_address
}

output "vm2_private_ip" {
  description = "Private IP address of VM2"
  value       = azurerm_network_interface.vm2_nic.private_ip_address
}

//VM Hostnames
output "vm1_hostname" {
  value = azurerm_linux_virtual_machine.vm1.name
}

output "vm2_hostname" {
  value = azurerm_linux_virtual_machine.vm2.name
}

//Private Endpoint IP
output "cognitive_private_ip" {
  description = "Private IP used by the Private Endpoint for Cognitive Services"
  value       = azurerm_private_endpoint.cog_pe.private_service_connection[0].private_ip_address
}
