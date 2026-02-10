resource "azurerm_traffic_manager_profile" "tm" {
  name                   = "tm-global-app"
  resource_group_name    = azurerm_resource_group.rg1.name
  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "globalwindowsappdemo"
    ttl           = 100
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager" "primary" {
  name               = "primary-endpoint"
  profile_id         = azurerm_traffic_manager_profile.tm.id
  type               = "externalEndpoints"
  target             = azurerm_public_ip.pip1.ip_address
  priority           = 1
}

resource "azurerm_traffic_manager" "secondary" {
  name       = "secondary-endpoint"
  profile_id = azurerm_traffic_manager_profile.tm.id
  type       = "externalEndpoints"
  target     = azurerm_public_ip.pip2.ip_address
  priority   = 2
} 
