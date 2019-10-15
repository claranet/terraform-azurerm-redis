output "redis_id" {
  value       = azurerm_redis_cache.redis.id
  description = "Redis instance id"
}

output "redis_hostname" {
  value       = azurerm_redis_cache.redis.hostname
  description = "Redis instance hostname"
}

output "redis_ssl_port" {
  value       = azurerm_redis_cache.redis.ssl_port
  description = "Redis instance SSL port"
}

output "redis_port" {
  value       = azurerm_redis_cache.redis.port
  description = "Redis instance port"
}

output "redis_primary_access_key" {
  sensitive   = true
  value       = azurerm_redis_cache.redis.primary_access_key
  description = "Redis primary access key"
}

output "redis_secondary_access_key" {
  sensitive   = true
  value       = azurerm_redis_cache.redis.secondary_access_key
  description = "Redis secondary access key"
}
