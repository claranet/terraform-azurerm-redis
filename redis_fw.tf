resource "azurerm_redis_firewall_rule" "redis_fw_rule" {
  for_each = var.authorized_cidrs
  name     = each.key

  redis_cache_name    = azurerm_redis_cache.redis.name
  resource_group_name = var.resource_group_name

  start_ip = cidrhost(each.value, 0)
  end_ip   = cidrhost(each.value, -1)
}
