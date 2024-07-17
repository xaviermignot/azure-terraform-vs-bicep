terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = "~> 1.7.0"

  backend "azurerm" {
    key = "state.tfstate"
  }
}

provider "azurerm" {
  features {}
}
