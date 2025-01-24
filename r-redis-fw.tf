resource "azurerm_redis_firewall_rule" "main" {
  for_each = local.allowed_cidrs
  name     = try(local.allowed_cidrs_names[each.key], data.azurecaf_name.redis_fw_rule[each.key].result)

  redis_cache_name    = azurerm_redis_cache.main.name
  resource_group_name = var.resource_group_name

  start_ip = cidrhost(each.value, 0)
  end_ip   = cidrhost(each.value, -1)
}

moved {
  from = azurerm_redis_firewall_rule.redis_fw_rule
  to   = azurerm_redis_firewall_rule.main
}
