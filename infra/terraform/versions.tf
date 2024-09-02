terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = "~> 1.8.0"

  backend "azurerm" {
    key = "state.tfstate"
  }
}

provider "azurerm" {
  features {}
}
