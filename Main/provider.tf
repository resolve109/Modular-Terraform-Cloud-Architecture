terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3..96"
        }
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 2.0"
        }
    }
}