resource "azurerm_redis_firewall_rule" "redis_fw_rule" {
  count = length(var.authorized_cidrs)

  name = "RedisFwRule${replace(cidrhost(element(var.authorized_cidrs, count.index), 0), ".", "")}"

  redis_cache_name    = azurerm_redis_cache.redis.name
  resource_group_name = var.resource_group_name

  start_ip = cidrhost(var.authorized_cidrs[count.index], 0)
  end_ip   = cidrhost(var.authorized_cidrs[count.index], -1)
}
