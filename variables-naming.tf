# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name"
  type        = string
  default     = ""
}

# Custom naming override
variable "custom_name" {
  description = "Custom name of Redis Server"
  type        = string
  default     = ""
}

variable "data_persistence_storage_custom_name" {
  description = "Custom name for the Storage Account used for Redis data persistence."
  type        = string
  default     = ""
}
