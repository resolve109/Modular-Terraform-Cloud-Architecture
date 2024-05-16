output "routing_rule_id" {
  description = "The ID of the Front Door routing rule"
  value       = azurerm_frontdoor_routing_rule.this.id
}

output "custom_domain_id" {
  description = "The ID of the Front Door custom domain"
  value       = azurerm_frontdoor_custom_domain.this.id
}

output "firewall_policy_id" {
  description = "The ID of the Front Door firewall policy"
  value       = azurerm_frontdoor_firewall_policy.this.id
}
