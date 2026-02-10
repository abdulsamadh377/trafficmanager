output "traffic_manager_dns" {
  value = azurerm_traffic_manager_profile.tm.fqdn
}