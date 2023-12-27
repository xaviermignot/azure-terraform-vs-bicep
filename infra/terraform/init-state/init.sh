#!/bin/sh

[ "$AZURE_LOCATION" ] || (echo "Please set the AZURE_LOCATION env variable"; exit)

script_dir=$(dirname "$0")
echo "Deploying in $AZURE_LOCATION..."
outputs=$(az deployment sub create -n 'deploy-tf-vs-bicep-state' -l "$AZURE_LOCATION" \
    -f "$script_dir/main.bicep" -p location="$AZURE_LOCATION" \
    --query '{ "resourceGroupName": properties.outputs.resourceGroupName.value, "containerName": properties.outputs.containerName.value, "storageAccountName": properties.outputs.storageAccountName.value }' \
| jq -c)

resource_group_name=$(echo "$outputs" | jq -r .resourceGroupName)
container_name=$(echo "$outputs" | jq -r .containerName)
account_name=$(echo "$outputs" | jq -r .storageAccountName)

backend_config_path="$script_dir/../config.azurerm.tfbackend"
echo "Writing the following content to the config.azurerm.tfbackend file:"
tee "$backend_config_path" << EOT
resource_group_name = "$resource_group_name"
storage_account_name = "$account_name"
container_name = "$container_name"
EOT

tofu -chdir="$(dirname "$backend_config_path")" init -backend-config="$backend_config_path"
