az login

$SUBSCRIPTION_ID = ""
$RESOURCE_GROUP_NAME = ""

az account set --subscription $SUBSCRIPTION_ID

# create ResourceGroup
az group create `
    --name "$RESOURCE_GROUP_NAME" `
    --location "southeastasia"

# create Service Principal
# Resource group level
# https://github.com/Azure/acs-engine/blob/master/docs/serviceprincipal.md
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP_NAME}"