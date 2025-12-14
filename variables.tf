# variables.tf

variable "resource_group_name" {
  description = "Name for the Azure Resource Group"
  type        = string
  default     = "terraform-project"
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

variable "replication_type" {
  description = "Replication type for the storage account ( ZRS )."
  type        = string
  default     = "ZRS"
}
