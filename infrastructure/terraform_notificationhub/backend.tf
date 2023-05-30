terraform {
  backend "azurerm" {
    storage_account_name = "notificationhubtfstate"
    resource_group_name = "rg-we-01-notification-hub-setup"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}