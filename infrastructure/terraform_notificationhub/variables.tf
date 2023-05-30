# Prerequisites
variable "subscription_id" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

# Actual infrastructure

variable "notification_hub_namespace_name" {
  type = string
}

variable "notification_hub_name" {
  type = string
}

variable "notification_hub_sku" {
  type = string
  default = "Standard"
}

variable "notification_hub_access_policy_name" {
  type = string
}

variable "notification_hub_gcm_api_key" {
  type = string
}

variable "log_workspace_subsciption_id" {
  type = string
}

variable "log_workspace_resource_group_name" {
  type = string
}

variable "log_workspace_name" {
  type = string
}