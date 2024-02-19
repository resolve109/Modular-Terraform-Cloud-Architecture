# Azure DevOps with Terraform Configuration Guide

## Overview
This guide provides instructions on how to securely store and manage sensitive data using Variable Groups in Azure DevOps Library for Terraform configurations. 

## Prerequisites
- An Azure DevOps account.
- A pipeline configured in Azure DevOps.
- Terraform installed and configured for Azure.

## Step 1: Create a Variable Group in Azure DevOps Library

1. Navigate to your Azure DevOps project.
2. Go to **Pipelines > Library > Variable Groups**.
3. Click on "+ Variable Group" to create a new one.
4. Provide a name and description for the Variable Group.
5. Use "+ Add" to add new variables. For sensitive data, ensure you check the "Keep this value secret" box.

## Step 2: Link Variable Group to Your Pipeline

1. In your Azure DevOps pipeline's YAML file, link the variable group using the following syntax:

   ```yaml
   variables:
     - group: <VariableGroupName>

Step 3: Use the Variables in Your Terraform Configuration
In your pipeline configuration file, pass the variables to your Terraform configuration with the -var option:

- task: TerraformTaskV1@0
  inputs:
    command: 'apply'
    environmentServiceName: '<YourServiceConnectionName>'
    workingDirectory: '$(System.DefaultWorkingDirectory)/<YourTerraformConfigurationPath>'
    additionalArguments: '-var "variable1=$(variable1)" -var "variable2=$(variable2)"'


Additional Information
For more detailed instructions and best practices, refer to the official Azure DevOps and Terraform documentation.

Security Note
Always keep your sensitive data, such as secrets and tokens, secure by using the "Keep this value secret" feature for variables in Azure DevOps.

Main/backend.tf: This file contains the configuration for the Terraform backend. The backend is responsible for storing your Terraform state and can also be used to run operations in the cloud.

Main/pipelines/azure-devops-pipeline.yaml: This file  contains the configuration for an Azure DevOps pipeline. This pipeline is probably used to test, build, and deploy your Terraform infrastructure.

Main/provider.tf: This file contains the configuration for the Terraform providers that are used in your project. Providers are responsible for understanding API interactions and exposing resources.

Main/root/data.tf: This file contains data source definitions. Data sources allow data to be fetched or computed for use elsewhere in your Terraform configuration.

Main/root/main.tf: This is the main entry point for your Terraform configuration. It  contains the root module that calls other modules defined in your project.

Main/root/modules: This directory contains the modules for your Terraform configuration. Modules are containers for multiple resources that are used together.

Compute: This module manages compute resources like virtual machines or Kubernetes clusters. It has specific configurations for AWS and Azure.
Network: This module manages network resources like virtual networks and subnets.
Storage: This module manages storage resources like Azure Containers and AWS S3 buckets.
Main/scripts/setup-azure-cli.sh: This script  sets up the Azure CLI on the machine where the Terraform code is being run. This could be used by the Azure provider or to interact with Azure services directly.

Main/terraform.tf: This file  contains additional Terraform configuration. The exact purpose would depend on the contents of the file.

root/modules/Storage/Azure Containers/Blobs: This module manages Azure Blob Storage resources.
root/modules/Storage/Azure Containers/Tables: This module manages Azure Table Storage resources.
root/modules/Storage/Azure Containers/Queues: This module manages Azure Queue Storage resources.
root/modules/Storage/Azure Containers/Files: This module manages Azure File Storage resources.
root/modules/Storage/S3: This module manages AWS S3 bucket resources.
root/modules/Storage/data.tf: This file contains data source definitions for storage resources.
root/modules/Storage/main.tf: This file contains the main configuration for storage resources.
root/modules/Storage/outputs.tf: This file contains output definitions for storage resources.
root/modules/Storage/variables.tf: This file contains variable definitions for storage resources.
root/modules/Network/data.tf: This file contains data source definitions for network resources.
root/modules/Network/outputs.tf: This file contains output definitions for network resources.
root/modules/Network/variables.tf: This file contains variable definitions for network resources.
root/modules/Network/main.tf: This file contains the main configuration for network resources.

### Folder Structure

For the folder structure, I'll layout a basic structure that separates your Terraform configurations from your Azure DevOps pipeline configurations for clarity and better management.
```
CLOUD INFRASTRUCTURE
|
├── Main
|   ├── readme.md
|
├── pipelines
|   └── azure-devops-pipeline.yaml
|
├── root
|   ├── modules
|   |   ├── Compute
|   |   |   ├── AWS
|   |   |   |   ├── AWS Kubernetes
|   |   |   |   ├── Elastic Container Registry
|   |   |   └── Azure
|   |   |       ├── Azure Kubernetes
|   |   |       ├── Azure Container Registry
|   |   |   ├── VMs
|   |   |   |   ├── Linux
|   |   |   |   |   ├── App VMs
|   |   |   |   └── Servers
|   |   |   └── Windows
|   |   |       ├── App VMs
|   |   |       └── Servers
|   |   |
|   |   ├── Network
|   |   |   ├── main.tf
|   |   |   ├── outputs.tf
|   |   |   └── variables.tf
|   |   |
|   |   └── Storage
|   |       ├── Azure Containers
|   |       ├── S3
|   |       ├── data.tf
|   |       ├── main.tf
|   |       ├── outputs.tf
|   |       └── variables.tf
|   |
|   ├── scripts
|   |   └── setup-azure-cli.sh
|   |
|   ├── backend.tf
|   ├── data.tf
|   ├── main.tf
|   ├── outputs.tf
|   ├── provider.tf
|   ├── terraform.tf
|   └── variables.tf
|
└── scripts
    └── setup-azure-cli.sh
```
