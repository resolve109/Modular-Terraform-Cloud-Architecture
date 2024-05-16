variable "sku" {
  description = "The SKU of the Traffic Manager profile"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "traffic_manager_name" {
  description = "The name of the Traffic Manager profile"
  type        = string
}

variable "profile_status" {
  description = "The status of the Traffic Manager profile"
  type        = string
}

variable "traffic_routing_method" {
  description = "The traffic routing method for the Traffic Manager profile"
  type        = string
}

variable "dns_config" {
  description = "The DNS configuration for the Traffic Manager profile"
  type        = map(any)
}

variable "monitor_config" {
  description = "The monitor configuration for the Traffic Manager profile"
  type        = map(any)
}

variable "endpoints" {
  description = "The endpoint configuration for the Traffic Manager profile"
  type        = list(map(any))
}
