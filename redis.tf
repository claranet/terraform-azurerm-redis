resource "azurerm_redis_cache" "redis" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  family   = lookup(local.redis_family_map, var.sku_name)
  sku_name = var.sku_name

  enable_non_ssl_port = var.allow_non_ssl_connections
  minimum_tls_version = var.minimum_tls_version
  shard_count         = var.sku_name == "Premium" ? var.cluster_shard_count : 0
  capacity            = var.capacity

  private_static_ip_address = var.private_static_ip_address
  subnet_id                 = var.subnet_id

  redis_version = var.redis_version

  tags = merge(local.default_tags, var.extra_tags)

  redis_configuration {
    enable_authentication           = lookup(local.redis_config, "enable_authentication", null)
    maxfragmentationmemory_reserved = lookup(local.redis_config, "maxfragmentationmemory_reserved", null)
    maxmemory_delta                 = lookup(local.redis_config, "maxmemory_delta", null)
    maxmemory_policy                = lookup(local.redis_config, "maxmemory_policy", null)
    maxmemory_reserved              = lookup(local.redis_config, "maxmemory_reserved", null)
    notify_keyspace_events          = lookup(local.redis_config, "notify_keyspace_events", null)
    rdb_backup_enabled              = lookup(local.redis_config, "rdb_backup_enabled", null)
    rdb_backup_frequency            = lookup(local.redis_config, "rdb_backup_frequency", null)
    rdb_backup_max_snapshot_count   = lookup(local.redis_config, "rdb_backup_max_snapshot_count", null)
    rdb_storage_connection_string   = lookup(local.redis_config, "rdb_storage_connection_string", null)
  }

  lifecycle {
    ignore_changes = [redis_configuration[0].rdb_storage_connection_string]
  }
}

resource "azurerm_storage_account" "redis_storage" {
  count = local.data_persistence_enabled ? 1 : 0

  name                = local.storage_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = var.data_persistence_storage_account_tier
  account_replication_type = var.data_persistence_storage_account_replication
  account_kind             = "StorageV2"

  tags = merge(local.default_tags, var.extra_tags)
}
