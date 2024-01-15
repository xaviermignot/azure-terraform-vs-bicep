# Terraform vs Bicep for Azure

This repository contains code samples for a blog post and a talk who compare Terraform and Bicep for working with Azure only. It also contains the slides of the talk (in French 🥖).  
The code samples provision a static website in a storage account both using Bicep and Terraform/Tofu.

## Use the code samples
The IaC files are living in the `infra` folder, there is a subfolder for Terraform and for Bicep.

### Terraform/tofu
Make sure the following prerequisites are met:
1. You are using a Linux-based environment (everything has been written/tested using Ubuntu 22.04 with WSL)
2. You have an Azure subscription
3. Azure CLI is installed and you are authenticated against your subscription
4. OpenTofu is installed (instructions [here](https://opentofu.org/docs/intro/install/))

If everything is ok, go to the `infra/terraform` folder from your terminal and run `init-state/init.sh -l <AZURE-REGION>` (replace `<AZURE-REGION>`) with the Azure region you want to use (`candaeast`, `francecentral`, etc.).  
This will provision a storage account to host Tofu's state in your Azure subscription, and initialize Tofu using the newly created file `config.azurerm.tfbackend` for the backend configuration.

Then you can go ahead and run `tofu validate`, `tofu plan` and `tofu apply` (or `tofu apply -auto-approve`) to provision the resources.

The URL of the static website is provided as an output of the `apply` command (you should see it at the very end of the output).

### Bicep
For Bicep you will only need an Azure subscription and Azure CLI installed and authenticated against your subscription.  
Go to the `infra/bicep` folder from your terminal (it has been tested with zsh but should work with PowerShell too) and run the following command to provision the resources (you can replace `canadaeast` with the location of your choice):
```shell
az deployment sub create -n deploy-tf-vs-bicep -l canadaeast -f main.bicep -p location=canadaeast
```
You can also replace `create` with `validate` if you just want to validate the syntax, of `what-if` to preview the changes.  

The URL of the static website is provided as an output of the deployment, you need to scroll up a little bit to see it, in the `properties.outputs.websiteEndpoint.value` properties of the JSON output. 

### Experiment !
Don't stop once the resources are created. Make changes to the code, mess things up from the portal, and run Bicep/Tofu again to see what happens !  
There are commented lines in the code, start by uncommenting these and see how it goes.

### Tearing up
Once you are done, don't forget to remove the created resources, even if they cost almost nothing:
- From the `infra/terraform` folder, run `tofu destroy -auto-approve` to destroy the resources provisioned with OpenTofu. Run also `az group delete -n rg-tf-vs-bicep-state` to remove the state's storage account.
- For Bicep, run `az group delete -n rg-tf-vs-bicep` from any folder.
