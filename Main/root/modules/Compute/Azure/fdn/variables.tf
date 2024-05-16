# Name of the resource group
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

# Location of the resource group
variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

# Name of the existing Front Door
variable "frontdoor_name" {
  description = "The name of the existing Front Door"
  type        = string
}

# Name of the routing rule
variable "routing_rule_name" {
  description = "The name of the routing rule"
  type        = string
}

# Name of the frontend endpoint
variable "frontend_endpoint_name" {
  description = "The name of the frontend endpoint"
  type        = string
}

# Name of the backend pool
variable "backend_pool_name" {
  description = "The name of the backend pool"
  type        = string
}

# Custom domain name
variable "custom_domain_name" {
  description = "The custom domain name"
  type        = string
}

# Certificate for the custom domain from Key Vault
variable "certificate" {
  description = "The certificate for the custom domain"
  type        = string
}

# Name of the security policy
variable "security_policy_name" {
  description = "The name of the security policy"
  type        = string
}

# Accepted protocols for the routing rule (default: ["Http", "Https"])
variable "accepted_protocols" {
  description = "Accepted protocols for the routing rule"
  type        = list(string)
  default     = ["Http", "Https"]
}

# Patterns to match for the routing rule (default: ["/*"])
variable "patterns_to_match" {
  description = "Patterns to match for the routing rule"
  type        = list(string)
  default     = ["/*"]
}

# Protocol to use for forwarding traffic (default: "MatchRequest")
variable "forwarding_protocol" {
  description = "Protocol to use for forwarding traffic"
  type        = string
  default     = "MatchRequest"
}

# Enable caching for the routing rule (default: false)
variable "cache_enabled" {
  description = "Enable caching for the routing rule"
  type        = bool
  default     = false
}

# Optional redirect configuration
variable "redirect_configuration" {
  description = "Optional redirect configuration"
  type = object({
    redirect_protocol = string
    custom_hostname   = string
    redirect_type     = string
  })
  default = null
}

# Name of the custom firewall rule
variable "custom_rule_name" {
  description = "The name of the custom firewall rule"
  type        = string
}

# Priority of the custom firewall rule
variable "custom_rule_priority" {
  description = "The priority of the custom firewall rule"
  type        = number
}

# Action of the custom firewall rule
variable "custom_rule_action" {
  description = "The action of the custom firewall rule"
  type        = string
}

# Match variable for the custom firewall rule
variable "custom_rule_match_variable" {
  description = "The match variable for the custom firewall rule"
  type        = string
}

# Operator for the custom firewall rule
variable "custom_rule_operator" {
  description = "The operator for the custom firewall rule"
  type        = string
}

# Match values for the custom firewall rule
variable "custom_rule_match_values" {
  description = "The match values for the custom firewall rule"
  type        = list(string)
}

# Type of the managed rule set (default: "DefaultRuleSet")
variable "rule_set_type" {
  description = "The type of the managed rule set"
  type        = string
  default     = "DefaultRuleSet"
}

# Version of the managed rule set (default: "1.0")
variable "rule_set_version" {
  description = "The version of the managed rule set"
  type        = string
  default     = "1.0"
}

  variable "frontend_endpoint_id" {
    description = "The ID of the Front Door frontend endpoint"
    type = string
  }
