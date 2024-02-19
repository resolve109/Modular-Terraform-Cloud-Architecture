variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}


variable "vnet_modules" {
    description = "Map of vnet modules"
    type = map(object({
        source = string
        name = string
        location = string
        resource_group_name = string
        address_space = list(string)
        key_vault_id = string
        shared_key_secret_name = string
        subnet_name = string
        address_prefix = list(string)
        nsg_name = string
        shared_key = string
        local_network_gateway_id = string
        vpn_gw_connection_name = string
        virtual_network_gateway_id = string
    }))
}