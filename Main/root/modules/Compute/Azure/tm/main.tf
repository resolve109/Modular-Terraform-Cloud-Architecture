resource "azurerm_traffic_manager_profile" "main" {
  name                = var.traffic_manager_name
  resource_group_name = var.resource_group_name
  profile_status      = var.profile_status
  traffic_routing_method = var.traffic_routing_method

  dns_config {
    relative_name = var.dns_config["relative_name"]
    ttl           = var.dns_config["ttl"]
  }

  monitor_config {
    protocol                     = var.monitor_config["protocol"]
    port                         = var.monitor_config["port"]
    path                         = var.monitor_config["path"]
    interval_in_seconds          = var.monitor_config["interval_in_seconds"]
    timeout_in_seconds           = var.monitor_config["timeout_in_seconds"]
    tolerated_number_of_failures = var.monitor_config["tolerated_number_of_failures"]
  }

  dynamic "endpoint" {
    for_each = var.endpoints
    content {
      name            = endpoint.value["name"]
      type            = endpoint.value["type"]
      target          = endpoint.value["target"]
      priority        = endpoint.value["priority"]
      weight          = endpoint.value["weight"]
      endpoint_status = endpoint.value["endpoint_status"]
    }
  }
}
