resource "azurerm_virtual_network" "vnet" {
    name                = var.name
    location            = var.location
    resource_group_name = var.resource_group_name
    address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.name
  address_prefixes     = [var.address_prefix]
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_key_vault_secret" "shared_key_secret" {
    name         = var.shared_key_secret_name
    value        = var.shared_key
    key_vault_id = var.key_vault_id
}

resource "azurerm_virtual_network_gateway_connection" "vpn_gw_connection" {
    name                             = var.vpn_gw_connection_name
    location                         = var.location
    resource_group_name              = var.resource_group_name
    virtual_network_gateway_id       = var.virtual_network_gateway_id
    local_network_gateway_id         = var.local_network_gateway_id
    shared_key                       = azurerm_key_vault_secret.shared_key_secret.value
    enable_bgp                       = false
    use_policy_based_traffic_selectors = true
    ipsec_policy {
        ipsec_encryption    = "AES256"
        ipsec_integrity     = "SHA256"
        ike_encryption      = "AES256"
        ike_integrity       = "SHA1"
        dh_group            = "DHGroup2"
        pfs_group           = "PFSGroup2"
    }
    type                             = "IPsec"
}