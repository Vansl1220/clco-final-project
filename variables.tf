variable "resource_group_name" {
  description = "Name for the Azure Resource Group"
  type        = string
  default     = "clco-currency-final"
}

variable "location" {
  description = "Azure region norwayeast"
  type        = string
  default     = "norwayeast"

}

variable "storage_account_name" {
  description = "Name for the Azure storrage account"
  type        = string
}

variable "app_service_name" {
  description = "Name for the Azure App Service"
  type        = string
  default     = "webapp-rg-clco-currency-final"
}

variable "replication_type" {
  description = "Replication type for the storage account ( ZRS )."
  type        = string
  default     = "ZRS"
}
