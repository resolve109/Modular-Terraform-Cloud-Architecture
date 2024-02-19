
/*
The `vnet` module creates a virtual network (VNet) in Azure for each entry in the `vnet_modules` map.

Each VNet includes the following resources:
- A VNet with the specified address space
- A subnet within the VNet with the specified address prefix
- A network security group (NSG) attached to the subnet
- A VPN gateway connection between the VNet and a local network gateway

The module takes the following inputs for each VNet:
- `source`: The path to the module
- `name`: The name of the VNet
- `location`: The Azure region where the VNet is created
- `resource_group_name`: The name of the resource group where the VNet is created
- `address_space`: The address space of the VNet
- `key_vault_id`: The ID of the Key Vault where the shared key is stored
- `shared_key_secret_name`: The name of the secret in the Key Vault that contains the shared key
- `subnet_name`: The name of the subnet within the VNet
- `address_prefix`: The address prefix of the subnet
- `nsg_name`: The name of the NSG attached to the subnet
- `shared_key`: The shared key for the VPN gateway connection
- `local_network_gateway_id`: The ID of the local network gateway for the VPN gateway connection
- `vpn_gw_connection_name`: The name of the VPN gateway connection
- `virtual_network_gateway_id`: The ID of the virtual network gateway for the VPN gateway connection

#To add more VNets, add more entries to the `vnet_modules` map in the `root/variables.tf` file.
#*/
#module "vnet" {
#    // ...
#}
module "vnet" {
    for_each = var.vnet_modules

    source              = each.value.source
    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    address_space       = each.value.address_space
    key_vault_id         = each.value.key_vault_id
    shared_key_secret_name = each.value.shared_key_secret_name
    subnet_name         = each.value.subnet_name
    address_prefix      = each.value.address_prefix
    nsg_name            = each.value.nsg_name
    shared_key          = each.value.shared_key
    local_network_gateway_id = each.value.local_network_gateway_id
    vpn_gw_connection_name = each.value.vpn_gw_connection_name
    virtual_network_gateway_id = each.value.virtual_network_gateway_id
}