#Storage Account  - name # if you want to use the same storage account,
# you can use the same name, but you need to change the resource group name

#Storage Account  - name

resource "azurerm_storage_account" "stracc1" { #"stracc1" is the name of the resource
    name                     = "nameastupidaccount"
    resource_group_name      = azurerm_resource_group.example.name
    location                 = azurerm_resource_group.example.location
    account_tier             = "Standard"
    account_replication_type = "GRS"

    tags = {
        environment = "staging"
    }


}

#Storage Account  - container
resource "azurerm_storage_container" "strcont1" { #"strcont1" is the name of the resource
  name                  = "nameacontainerstupid"
  storage_account_name  = azurerm_storage_account.strcont1.name
  container_access_type = "private"
}

#Storage Account  - blob
resource "azurerm_storage_blob" "strblob1" { # "strblob1" is the name of the resource
  name                   = "nameablobstupid"
  storage_account_name   = azurerm_storage_account.stracc1.name # Required - the name of the storage account
  storage_container_name = azurerm_storage_container.strcont1.name  # Required - the name of the container in which the blob should be created
  type                   = "Block" # Required - the type of blob to create - Block or Page
  source                 = "example.txt" # Path to the file to be uploaded
} 

#Storage Account  - blob
resource "azurerm_storage_blob" "strblob2" { # "strblob2" is the name of the resource
  name                   = "nameablobstupid2" # Required - the name of the blob
  storage_account_name   = azurerm_storage_account.stracc1.name # Required - the name of the storage account
  storage_container_name = azurerm_storage_container.strcont1.name # Required - the name of the container in which the blob should be created
  type                   = "Block" # Required - the type of blob to create - Block or Page
  source                 = "example2.txt" # Path to the file to be uploaded
}

data "azurerm_storage_account_sas" "sastracc1" { # "sastracc1" is the name of the resource
    connection_string = azurerm_storage_account.stracc1.primary_connection_string   # Required - the connection string for the storage account
    https_only        = true # Optional - defaults to true
 
    resource_types {  # Optional - if not specified, all resource types are included
        service   = true # Allow access to the service - required for container and object level access
        container = false # Allow access to the container level - required for object level access
        object    = false  # Allow access to the object level - required for object level access
    }

    services {
        blob  = true  # Allow access to the blob service - required for container and object level access
        queue = false # Allow access to the queue service - only valid for standard storage accounts
        table = false # Allow access to the table service - only valid for classic storage accounts
        file  = false # Allow access to the file service - only valid for premium storage accounts 
    }

    start  = "2020-01-01" # Date in the past - required for the expiry to be valid - format YYYY-MM-DD 
    expiry = "2022-01-01" # Date in the future - required for the expiry to be valid - format YYYY-MM-DD

    permissions {
        tag     = "example_tag" # Optional tag
        filter  = "example_filter" # Optional filter - service version
        read    = true # Allow read access - applies to container and blob
        write   = true # Allow write access - applies to container and blob
        delete  = false # Allow delete access - applies to container and blob
        list    = true  # Allow list access - applies to container and blob 
        add     = true # Allow add access - applies to container and blob
        create  = true # Allow create access (add and write) - applies to container and blob 
        update  = false
        process = false
    }
}


