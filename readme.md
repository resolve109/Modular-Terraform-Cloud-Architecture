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


### Folder Structure

For the folder structure, I'll layout a basic structure that separates your Terraform configurations from your Azure DevOps pipeline configurations for clarity and better management.

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

