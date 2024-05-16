# Configure the Front Door routing rule
resource "azurerm_frontdoor_routing_rule" "this" {
  name                = var.routing_rule_name
  resource_group_name = var.resource_group_name
  frontdoor_name      = var.frontdoor_name

  accepted_protocols = var.accepted_protocols
  patterns_to_match  = var.patterns_to_match

  frontend_endpoints {
    name = var.frontend_endpoint_name
  }

  forwarding_configuration {
    backend_pool_name   = var.backend_pool_name
    forwarding_protocol = var.forwarding_protocol
    cache_enabled       = var.cache_enabled
  }

  dynamic "redirect_configuration" {
    for_each = var.redirect_configuration != null ? [var.redirect_configuration] : []
    content {
      redirect_protocol = redirect_configuration.value.redirect_protocol
      custom_hostname   = redirect_configuration.value.custom_hostname
      redirect_type     = redirect_configuration.value.redirect_type
    }
  }
}

# Configure the custom HTTPS settings for the custom domain
resource "azurerm_frontdoor_custom_https_configuration" "this" {
  name                       = var.custom_domain_name
  frontend_endpoint_id       = var.frontend_endpoint_id
  
  # Required attribute for HTTPS provisioning
  custom_https_provisioning_enabled = true
  
  custom_https_configuration {
    certificate_source = "FrontDoor"
  }
}

# Configure the custom domain for the Front Door
resource "azurerm_frontdoor_custom_domain" "this" {
  name                = var.custom_domain_name
  resource_group_name = var.resource_group_name
  frontdoor_name      = var.frontdoor_name
  host_name           = var.custom_domain_name
}

# Configure the Front Door firewall policy
resource "azurerm_frontdoor_firewall_policy" "this" {
  name                = var.security_policy_name
  resource_group_name = var.resource_group_name

  custom_rules {
    name      = var.custom_rule_name
    priority  = var.custom_rule_priority
    action    = var.custom_rule_action
    rule_type = "MatchRule"

    match_conditions {
      match_variable = var.custom_rule_match_variable
      operator       = var.custom_rule_operator
      match_values   = var.custom_rule_match_values
    }
  }
}

# Configure the managed rule set for the firewall policy
resource "azurerm_frontdoor_managed_rule_set" "this" {
  name                = "DefaultRuleSet"
  resource_group_name = var.resource_group_name
  frontdoor_name      = var.frontdoor_name

  managed_rule {
    rule_set_type    = var.rule_set_type
    rule_set_version = var.rule_set_version
  }
}
