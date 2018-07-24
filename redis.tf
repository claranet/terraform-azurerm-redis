# Basic Redis
resource "azurerm_redis_cache" "redis" {
  name                = "redis-${var.environment}-${var.azure_region_short}-${var.client_name}-${var.stack}-${var.redis_name}"
  location            = "${var.azure_region}"
  resource_group_name = "${var.resource_group_name}"
  capacity            = "${var.redis_capacity}"
  family              = "${var.redis_family}"
  sku_name            = "${var.redis_sku_name}"
  enable_non_ssl_port = "${var.redis_enable_ssl}"

  redis_configuration = {
    maxmemory_reserved = "${var.redis_configuration["maxmemory_reserved"]}"
    maxmemory_delta    = "${var.redis_configuration["maxmemory_delta"]}"
    maxmemory_policy   = "${var.redis_configuration["maxmemory_policy"]}"
  }
}
