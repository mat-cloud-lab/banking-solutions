resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "terraform_state" {
  resource_group_name = azurerm_resource_group.default.name
  name = var.tfstate_storage_name
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
  location = azurerm_resource_group.default.location
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = var.tfstate_container_name
  storage_account_name  = azurerm_storage_account.terraform_state.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "terraform_state_blob_owner_assignement" {
  scope                = azurerm_storage_account.terraform_state.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}