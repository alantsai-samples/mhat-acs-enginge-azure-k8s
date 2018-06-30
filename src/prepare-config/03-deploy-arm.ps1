# generate
.\acs-engine.exe generate d:\workdir\k8s\kubernetes.json

# deploy
# https://github.com/Azure/acs-engine/blob/master/docs/acsengine.md#deployment-usage
$DNS_PREFIX = ""
az group deployment create `
    --name "atk8sacsenginevmssdeploy" `
    --resource-group "${RESOURCE_GROUP_NAME}" `
    --template-file "../_output/${DNS_PREFIX}/azuredeploy.json" `
    --parameters "../_output/${DNS_PREFIX}/azuredeploy.parameters.json"

# check vm name
az vm list -g ${RESOURCE_GROUP_NAME} -o table
