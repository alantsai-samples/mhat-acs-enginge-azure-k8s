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

# generate
.\acs-engine.exe generate d:\workdir\k8s\kubernetes.json

# deploy
# https://github.com/Azure/acs-engine/blob/master/docs/acsengine.md#deployment-usage
$DNS_PREFIX = ""
az group deployment create `
    --name "atk8sacsenginevmssdeploy" `
    --resource-group "${RESOURCE_GROUP_NAME}" `
    --template-file "./_output/${DNS_PREFIX}/azuredeploy.json" `
    --parameters "./_output/${DNS_PREFIX}/azuredeploy.parameters.json"

# check vm name
az vm list -g ${RESOURCE_GROUP_NAME} -o table