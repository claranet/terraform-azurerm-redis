variable "location" {
  description = "Azure region in which instance will be hosted"
  type        = string
}

variable "location_short" {
  description = "Azure region trigram"
  type        = string
}

variable "environment" {
  description = "Name of the application's environnement"
  type        = string
}

variable "stack" {
  description = "Name of the application stack"
  type        = string
}

variable "client_name" {
  description = "Name of the client"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the application ressource group, herited from infra module"
  type        = string
}

variable "custom_name" {
  description = "Custom name of redis server"
  type        = string
  default     = ""
}

variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "extra_tags" {
  description = "Map of extra tags"
  type        = map(string)
  default     = {}
}

variable "capacity" {
  description = "Redis size: (Basic/Standard: 1,2,3,4,5,6) (Premium: 1,2,3,4)  https://docs.microsoft.com/fr-fr/azure/redis-cache/cache-how-to-premium-clustering"
  type        = number
  default     = 2
}

variable "sku_name" {
  description = "Redis Cache Sku name. Can be Basic, Standard or Premium"
  type        = string
  default     = "Premium"
}

variable "cluster_shard_count" {
  description = "Number of cluster shards desired"
  type        = number
  default     = 3
}

variable "redis_additional_configuration" {
  description = "Additional configuration for the Redis instance. Some of the keys are set automatically. See https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html#redis_configuration for full reference."
  type        = map(string)
  default     = {}
}

variable "authorized_cidrs" {
  description = "Map of authorized cidrs"
  type        = map(string)
}

variable "allow_non_ssl_connections" {
  description = "Activate non SSL port (6779) for Redis connection"
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "The minimum TLS version"
  type        = string
  default     = "1.0"
}

variable "private_static_ip_address" {
  description = "The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "The ID of the Subnet within which the Redis Cache should be deployed. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "data_persistence_enabled" {
  description = "\"true\" to enable data persistence."
  type        = bool
  default     = true
}

variable "data_persistence_frequency_in_minutes" {
  description = "Data persistence snapshot frequency in minutes."
  type        = number
  default     = 60
}

variable "data_persistence_max_snapshot_count" {
  description = "Max number of data persistence snapshots."
  type        = number
  default     = null
}

variable "data_persistence_storage_custom_name" {
  description = "Custom name for the Storage Account used for Redis data persistence."
  type        = string
  default     = ""
}

variable "data_persistence_storage_account_tier" {
  description = "Replication type for the Storage Account used for data persistence."
  type        = string
  default     = "Premium"
}

variable "data_persistence_storage_account_replication" {
  description = "Replication type for the Storage Account used for data persistence."
  type        = string
  default     = "LRS"
}
