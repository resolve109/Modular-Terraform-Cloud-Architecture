provider "azurerm" {
  features {}
}

# Define the resource group to be used
data "azurerm_resource_group" "my_rg" {
  name = "my-resource-group"
}

# Use the frontdoor_configuration module
module "frontdoor_configuration" {
  source = "./modules/frontdoor_configuration"

  # Specify the resource group details using data source
  resource_group_name    = data.azurerm_resource_group.my_rg.name
  resource_group_location = data.azurerm_resource_group.my_rg.location
  frontdoor_name         = "my-existing-frontdoor"
  routing_rule_name      = "my-routing-rule"
  frontend_endpoint_name = "my-frontend-endpoint"
  backend_pool_name      = "my-backend-pool"
  custom_domain_name     = "www.mydomain.com"
  custom_domain_host_name = "www.mydomain.com"
  certificate            = "/subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.KeyVault/vaults/<keyvault-name>/secrets/<secret-name>"
  security_policy_name   = "my-security-policy"

  # Optional configurations
  accepted_protocols     = ["Https"]
  patterns_to_match      = ["/api/*"]
  forwarding_protocol    = "HttpsOnly"
  cache_enabled          = true
  redirect_configuration = {
    redirect_protocol = "HttpsOnly"
    custom_hostname   = "www.redirected-domain.com"
    redirect_type     = "MovedPermanently"
  }

  # Custom firewall rule configurations
  custom_rule_name         = "AllowGetRequests"
  custom_rule_priority     = 1
  custom_rule_action       = "Allow"
  custom_rule_match_variable = "RequestMethod"
  custom_rule_operator     = "Equal"
  custom_rule_match_values = ["GET"]

  # Managed rule set configurations
  rule_set_type    = "DefaultRuleSet"
  rule_set_version = "1.0"
}



module "traffic_manager_1" {
  source = "./modules/traffic_manager"

  sku                   = "Standard"
  resource_group_name   = "rg-traffic-manager-1"
  traffic_manager_name  = "tm-profile-1"
  profile_status        = "Enabled"
  traffic_routing_method = "Performance"
  dns_config = {
    relative_name = "tm1"
    ttl           = 60
  }
  monitor_config = {
    protocol                     = "HTTP"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }
  endpoints = [
    {
      name            = "endpoint1"
      type            = "externalEndpoints"
      target          = "example1.com"
      priority        = 1
      weight          = 50
      endpoint_status = "Enabled"
    },
    {
      name            = "endpoint2"
      type            = "externalEndpoints"
      target          = "example2.com"
      priority        = 2
      weight          = 50
      endpoint_status = "Enabled"
    }
  ]
}


module "traffic_manager_2" {
  source = "./modules/traffic_manager"

  sku                   = "Premium"
  resource_group_name   = "rg-traffic-manager-2"
  traffic_manager_name  = "tm-profile-2"
  profile_status        = "Enabled"
  traffic_routing_method = "Weighted"
  dns_config = {
    relative_name = "tm2"
    ttl           = 60
  }
  monitor_config = {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = "/health"
    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }
  endpoints = [
    {
      name            = "endpoint1"
      type            = "externalEndpoints"
      target          = "example3.com"
      priority        = 1
      weight          = 50
      endpoint_status = "Enabled"
    },
    {
      name            = "endpoint2"
      type            = "externalEndpoints"
      target          = "example4.com"
      priority        = 2
      weight          = 50
      endpoint_status = "Enabled"
    }
  ]
}