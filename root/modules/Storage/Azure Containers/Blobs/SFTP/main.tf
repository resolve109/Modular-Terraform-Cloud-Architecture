# Resource group creation
resource "azurerm_resource_group" "my_resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Storage account creation
resource "azurerm_storage_account" "strgacc1" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.my_resource_group.name
  location                 = azurerm_resource_group.my_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage container creation
resource "azurerm_storage_container" "strgacccont1" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

# Storage share creation
resource "azurerm_storage_share" "strgshare1" {
  name                 = var.storage_share_name
  storage_account_name = azurerm_storage_account.example.name
  quota                = 50
}

# Storage directory creation
resource "azurerm_storage_directory" "strgdir1" {
  name                 = var.storage_directory_name
  storage_account_name = azurerm_storage_account.example.name
  share_name           = azurerm_storage_share.example.name
}

# Storage file creation
resource "azurerm_storage_file" "strgfile1" {
  name                 = var.storage_file_name
  storage_account_name = azurerm_storage_account.example.name
  share_name           = azurerm_storage_share.example.name
  directory_name       = azurerm_storage_directory.example.name
  source               = var.local_file_path
}

# Virtual network creation
resource "azurerm_virtual_network" "strgvnet1" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
}

# Subnet creation
resource "azurerm_subnet" "strgsub1" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Key vault creation
resource "azurerm_key_vault" "strgkv1" {
  name                        = var.key_vault_name
  resource_group_name         = azurerm_resource_group.my_resource_group.name
  location                    = azurerm_resource_group.my_resource_group.location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
}

# Key vault access policy creation
resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.object_id

  certificate_permissions = [
    "get",
    "list",
    "create",
    "import",
    "delete",
    "update",
    "backup",
    "restore",
  ]

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
    "backup",
    "restore",
  ]

  storage_permissions = [
    "get",
    "list",
    "delete",
    "set",
    "update",
    "regeneratekey",
    "recover",
    "purge",
  ]

  key_permissions = [
    "get",
    "list",
    "create",
    "import",
    "delete",
    "update",
    "backup",
    "restore",
    "recover",
    "purge",
  ]
}

# SFTP server creation
resource "azurerm_sftp_server" "example" {
  name                 = var.sftp_server_name
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  location             = azurerm_resource_group.my_resource_group.location
  storage_account_name = azurerm_storage_account.example.name
  storage_share_name   = azurerm_storage_share.example.name
  storage_directory_id = azurerm_storage_directory.example.id
  ssh_public_key       = file("~/.ssh/id_rsa.pub")
  vnet_subnet_id       = azurerm_subnet.example.id
  key_vault_id         = azurerm_key_vault.example.id
}
