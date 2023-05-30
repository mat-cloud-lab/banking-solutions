resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_notification_hub_namespace" "default" {
  name                = var.notification_hub_namespace_name
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  namespace_type      = "NotificationHub"

  sku_name = var.notification_hub_sku
}

resource "azurerm_notification_hub" "default" {
  name                = var.notification_hub_name
  namespace_name      = azurerm_notification_hub_namespace.default.name
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  gcm_credential {
    api_key = var.notification_hub_gcm_api_key
  }
}

resource "azurerm_notification_hub_authorization_rule" "backend_access_policy" {
  name                  = var.notification_hub_access_policy_name
  notification_hub_name = azurerm_notification_hub.default.name
  namespace_name        = azurerm_notification_hub_namespace.default.name
  resource_group_name   = azurerm_resource_group.default.name
  manage                = false
  send                  = true
  listen                = true
}

resource "azurerm_monitor_diagnostic_setting" "notification_hub_namespace_logs" {
  name               = "security-logs"
  target_resource_id = azurerm_notification_hub_namespace.default.id
  log_analytics_workspace_id = "/subscriptions/${var.log_workspace_subsciption_id}/resourceGroups/${var.log_workspace_resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${var.log_workspace_name}"

  enabled_log {
    category = "OperationalLogs"

    retention_policy {
      enabled = true
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "activity_logs" {
  name               = "security-logs"
  target_resource_id = "/subscriptions/${var.log_workspace_subsciption_id}"
  log_analytics_workspace_id = "/subscriptions/${var.log_workspace_subsciption_id}/resourceGroups/${var.log_workspace_resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/${var.log_workspace_name}"

  enabled_log {
    category = "Administrative"
    
    retention_policy {
      days    = 0
      enabled = false
    }
  }

  enabled_log {
    category = "Security"
    
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  
  enabled_log {
    category = "ServiceHealth"
    
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  
  enabled_log {
    category = "Alert"
    
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  
  enabled_log {
    category = "Recommendation"
    
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  
  enabled_log {
    category = "Policy"
    
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  
  enabled_log {
    category = "Autoscale"
    
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  
  enabled_log {
    category = "ResourceHealth"
    
    retention_policy {
      days    = 0
      enabled = false
    }
  }
}

output "notification_hub_connection_string" {
  value = "Endpoint=sb://${var.notification_hub_namespace_name}.servicebus.windows.net/;SharedAccessKeyName=${var.notification_hub_access_policy_name};SharedAccessKey=${azurerm_notification_hub_authorization_rule.backend_access_policy.primary_access_key}"
}

output "notification_hub_name" {
  value = var.notification_hub_name
}