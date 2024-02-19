variable "name" {
    description = "The name of the virtual network"
    type        = string
}

variable "location" {
    description = "The location of the virtual network"
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group in which to create the virtual network"
    type        = string
}

variable "address_space" {
    description = "The address space that is used by the virtual network"
    type        = list(string)
}
variable "subnet_name" {
    description = "The name of the subnet"
    type        = string
}

variable "address_prefix" {
    description = "The address prefix for the subnet"
    type        = string
}

variable "nsg_name" {
    description = "The name of the network security group"
    type        = string
}

variable "shared_key_secret_name" {
    description = "The name of the shared key secret in the key vault"
    type        = string
}

variable "shared_key" {
    description = "The shared key for the VPN gateway connection"
    type        = string
}

variable "key_vault_id" {
    description = "The ID of the key vault"
    type        = string
}

variable "vpn_gw_connection_name" {
    description = "The name of the VPN gateway connection"
    type        = string
}

variable "virtual_network_gateway_id" {
    description = "The ID of the virtual network gateway"
    type        = string
}

variable "local_network_gateway_id" {
    description = "The ID of the local network gateway"
    type        = string
}

variable "local_network_gateway_id" {
    description = "The ID of the local network gateway"
    type        = string
}

variable "vpn_gw_connection_name" {
    description = "The name of the VPN gateway connection"
    type        = string
}

variable "virtual_network_gateway_id" {
    description = "The ID of the virtual network gateway"
    type        = string
}