terraform {
    backend "s3" {
        bucket = var.s3_bucket
        key    = var.s3_key
        region = var.s3_region
    }
}

terraform {
    backend "azurerm" {
        resource_group_name  = var.azure_resource_group
        storage_account_name = var.azure_storage_account
        container_name       = var.azure_container
        key                  = var.azure_key
    }
}

provider "azurerm" {

    features {}
}

provider "aws" {

}

resource "null_resource" "azure_cli_setup" {
    provisioner "local-exec" {
        command = "${path.module}/../scripts/setup-azure-cli.sh"
    }
}