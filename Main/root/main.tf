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