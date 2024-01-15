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

If everything is ok, go to the `infra/terraform` folder from your terminal and run `init-state/init.sh -l <AZURE-REGION>` (replace `<AZURE-REGION>`) with the Azure region you want to use (`candacentral`, `francecentral`, etc.).  
This will provision a storage account to host Tofu's state in your Azure subscription, and initialize Tofu using the newly created file `config.azurerm.tfbackend` for the backend configuration.

Then you can go ahead and run `tofu validate`, `tofu plan` and `tofu apply` (or `tofu apply -auto-approve`) to provision the resources.