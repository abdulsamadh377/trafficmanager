resource "azurerm_traffic_manager_profile" "tm" {
  name                = "tm-demo-profile"
  resource_group_name = azurerm_resource_group.rg.name

  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "tmabduldemo"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}
resource "azurerm_traffic_manager_endpoint" "primary" {
  name                = "primary-endpoint"
  profile_name        = azurerm_traffic_manager_profile.tm.name
  resource_group_name = azurerm_resource_group.rg.name

  type               = "azureEndpoints"
  target_resource_id = azurerm_public_ip.primary.id
  priority           = 1
}
resource "azurerm_traffic_manager_endpoint" "secondary" {
  name                = "secondary-endpoint"
  profile_name        = azurerm_traffic_manager_profile.tm.name
  resource_group_name = azurerm_resource_group.rg.name

  type               = "azureEndpoints"
  target_resource_id = azurerm_public_ip.secondary.id
  priority           = 2
}
