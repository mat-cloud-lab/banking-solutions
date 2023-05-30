resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "security_logs" {
  name                = "example-workspace"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "security_logs" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.default.location
  resource_group_name   = azurerm_resource_group.default.name
  workspace_resource_id = azurerm_log_analytics_workspace.security_logs.id
  workspace_name        = azurerm_log_analytics_workspace.security_logs.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}