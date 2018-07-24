resource "azurerm_redis_firewall_rule" "redis_fw_rule" {
  name                = "RedisRule${replace(cidrhost(element(var.admin_cidrs, count.index), 0), ".","")}"
  count               = "${length(var.admin_cidrs)}"
  redis_cache_name    = "${azurerm_redis_cache.redis.name}"
  resource_group_name = "${var.resource_group_name}"
  start_ip            = "${cidrhost(element(var.admin_cidrs, count.index), 0)}"
  end_ip              = "${cidrhost(element(var.admin_cidrs, count.index), -1)}"
}
