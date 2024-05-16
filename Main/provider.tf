terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3..96"
        }
     
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.9.6"
        }
    }
}


provider "azurerm" {
  features {}
}


