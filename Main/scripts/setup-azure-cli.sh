# In this script, I've made the following changes:
# 
# Removed duplicate provider registrations.
# Added a check to see if the service principal 
# already exists before creating a new one.
# Extracted the service principal credentials from
# the output of the az ad sp create-for-rbac command instead of using placeholders.
# Replaced the placeholders with environment variables for sensitive data.
# You'll need to set the following environment variables before running this script:
# 
# AZURE_SUBSCRIPTION_ID
# AZURE_RESOURCE_GROUP_NAME
# AZURE_LOCATION
# AZURE_SP_NAME
# This script assumes that jq is installed on your machine.
# If it's not, you'll need to install it first. jq is a lightweight and flexible
# command-line JSON processor. It's used in this script to parse the JSON output 
# of the az ad sp create-for-rbac command.


#!/bin/bash

# Login to Azure CLI
az login

# Set the subscription
az account set --subscription "${AZURE_SUBSCRIPTION_ID}"

# Set the default resource group
az configure --defaults group="${AZURE_RESOURCE_GROUP_NAME}"

# Set the default location
az configure --defaults location="${AZURE_LOCATION}"

# Register Azure resource providers
declare -a providers=("Microsoft.Network" "Microsoft.Storage" "Microsoft.Compute" "Microsoft.ContainerService" "Microsoft.ContainerRegistry" "Microsoft.KeyVault" "Microsoft.Web" "Microsoft.DBforMySQL" "Microsoft.DBforPostgreSQL" "Microsoft.DBforMariaDB" "Microsoft.DBforSQL" "Microsoft.Cache" "Microsoft.EventGrid" "Microsoft.EventHub" "Microsoft.ServiceBus" "Microsoft.SignalRService" "Microsoft.CognitiveServices" "Microsoft.ApiManagement" "Microsoft.Logic" "Microsoft.OperationalInsights" "Microsoft.Automation")

for provider in "${providers[@]}"
do
  az provider register --namespace "${provider}"
done

# Check if the service principal already exists
sp_exists=$(az ad sp list --display-name "${AZURE_SP_NAME}" --query "[].appId" -o tsv)

if [ -z "${sp_exists}" ]; then
  # Create a service principal
  sp=$(az ad sp create-for-rbac --name "${AZURE_SP_NAME}" --role contributor --scopes /subscriptions/${AZURE_SUBSCRIPTION_ID}/resourceGroups/${AZURE_RESOURCE_GROUP_NAME} --sdk-auth)

  # Extract the service principal credentials
  SP_APP_ID=$(echo "${sp}" | jq -r '.clientId')
  SP_PASSWORD=$(echo "${sp}" | jq -r '.clientSecret')
  SP_TENANT_ID=$(echo "${sp}" | jq -r '.tenantId')

  # Set the service principal credentials
  az configure --defaults ad_app="${SP_APP_ID}"
  az configure --defaults ad_password="${SP_PASSWORD}"
  az configure --defaults ad_tenant="${SP_TENANT_ID}"
  az configure --defaults subscription="${AZURE_SUBSCRIPTION_ID}"
else
  echo "Service Principal ${AZURE_SP_NAME} already exists."
fi