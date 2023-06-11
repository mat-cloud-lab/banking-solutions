terraform {
  backend "azurerm" {
    storage_account_name = "#{tfStateAzureStorageAccountName}#"
    resource_group_name = "#{tfStateResourceGroupName}#"
    container_name = "#{tfStateContainerName}#"
    key = "#{tfStateFileName}#"
  }
}