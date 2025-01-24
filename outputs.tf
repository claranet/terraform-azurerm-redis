output "resource" {
  description = "Redis instance object."
  value       = azurerm_redis_cache.main
  sensitive   = true
}

output "resource_storage" {
  description = "Redis storage account outputs."
  value       = azurerm_storage_account.main
  sensitive   = true
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}

output "id" {
  description = "Redis instance id."
  value       = azurerm_redis_cache.main.id
}

output "name" {
  description = "Redis instance name."
  value       = azurerm_redis_cache.main.name
}

output "hostname" {
  description = "Redis instance hostname."
  value       = azurerm_redis_cache.main.hostname
}

output "ssl_port" {
  description = "Redis instance SSL port."
  value       = azurerm_redis_cache.main.ssl_port
}

output "port" {
  description = "Redis instance port."
  value       = azurerm_redis_cache.main.port
}

output "primary_access_key" {
  description = "Redis instance primary access key."
  value       = azurerm_redis_cache.main.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Redis instance secondary access key."
  value       = azurerm_redis_cache.main.secondary_access_key
  sensitive   = true
}

output "private_static_ip_address" {
  description = "Redis instance private static IP address."
  value       = azurerm_redis_cache.main.private_static_ip_address
}

output "sku_name" {
  description = "Redis instance SKU name."
  value       = azurerm_redis_cache.main.sku_name
}

output "family" {
  description = "Redis instance family."
  value       = azurerm_redis_cache.main.family
}

output "capacity" {
  description = "Redis instance capacity."
  value       = azurerm_redis_cache.main.capacity
}

output "configuration" {
  description = "Redis instance configuration."
  value       = azurerm_redis_cache.main.redis_configuration
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string of the Redis instance."
  value       = azurerm_redis_cache.main.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string of the Redis instance."
  value       = azurerm_redis_cache.main.secondary_connection_string
  sensitive   = true
}

output "terraform_module" {
  description = "Information about this Terraform module."
  value = {
    name       = "redis"
    provider   = "azurerm"
    maintainer = "claranet"
  }
}
