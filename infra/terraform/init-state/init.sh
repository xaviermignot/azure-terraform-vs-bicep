#!/bin/sh

while getopts ":l:" opt; do
    case "${opt}" in
    l) azure_location=${OPTARG} ;;
    \?) echo "Invalid option: -$OPTARG" >&2 || exit 1 ;;
    esac
done

# Return errors if any argument or varenv is missing
: "${azure_location:?Missing -l argument (azure location)}"

script_dir=$(dirname "$0")
echo "Deploying in $azure_location..."
outputs=$(az deployment sub create -n 'deploy-tf-vs-bicep-state' -l "$azure_location" \
    -f "$script_dir/main.bicep" -p location="$azure_location" \
    --query '{ "resourceGroupName": properties.outputs.resourceGroupName.value, "containerName": properties.outputs.containerName.value, "storageAccountName": properties.outputs.storageAccountName.value }' |
    jq -c)

resource_group_name=$(echo "$outputs" | jq -r .resourceGroupName)
container_name=$(echo "$outputs" | jq -r .containerName)
account_name=$(echo "$outputs" | jq -r .storageAccountName)

backend_config_path="$script_dir/../config.azurerm.tfbackend"
echo "Writing the following content to the config.azurerm.tfbackend file:"
tee "$backend_config_path" <<EOT
resource_group_name = "$resource_group_name"
storage_account_name = "$account_name"
container_name = "$container_name"
EOT

tofu -chdir="$(dirname "$backend_config_path")" init -backend-config="$backend_config_path"
