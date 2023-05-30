terraform {
  required_providers {
    azurerm = {
      version = "=3.54.0"
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
}