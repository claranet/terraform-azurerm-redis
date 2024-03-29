resource "azurerm_redis_cache" "redis" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  family   = local.redis_family_map[var.sku_name]
  sku_name = var.sku_name

  enable_non_ssl_port = var.allow_non_ssl_connections
  minimum_tls_version = var.minimum_tls_version
  shard_count         = var.sku_name == "Premium" ? var.cluster_shard_count : 0
  capacity            = var.capacity

  public_network_access_enabled = var.public_network_access_enabled
  private_static_ip_address     = var.private_static_ip_address
  subnet_id                     = var.subnet_id

  redis_version = var.redis_version
  zones         = var.zones

  tags = merge(local.default_tags, var.extra_tags)

  dynamic "redis_configuration" {
    for_each = local.redis_config[*]
    content {
      aof_backup_enabled                      = redis_configuration.value.aof_backup_enabled
      aof_storage_connection_string_0         = redis_configuration.value.aof_storage_connection_string_0
      aof_storage_connection_string_1         = redis_configuration.value.aof_storage_connection_string_1
      enable_authentication                   = redis_configuration.value.enable_authentication
      active_directory_authentication_enabled = redis_configuration.value.active_directory_authentication_enabled
      maxmemory_reserved                      = redis_configuration.value.maxmemory_reserved
      maxmemory_delta                         = redis_configuration.value.maxmemory_delta
      maxmemory_policy                        = redis_configuration.value.maxmemory_policy
      maxfragmentationmemory_reserved         = redis_configuration.value.maxfragmentationmemory_reserved
      rdb_backup_enabled                      = redis_configuration.value.rdb_backup_enabled
      rdb_backup_frequency                    = redis_configuration.value.rdb_backup_frequency
      rdb_backup_max_snapshot_count           = redis_configuration.value.rdb_backup_max_snapshot_count
      rdb_storage_connection_string           = redis_configuration.value.rdb_storage_connection_string
      notify_keyspace_events                  = redis_configuration.value.notify_keyspace_events
    }
  }

  lifecycle {
    ignore_changes = [redis_configuration[0].rdb_storage_connection_string]
  }

  dynamic "patch_schedule" {
    for_each = var.patch_schedules
    content {
      day_of_week        = patch_schedule.value.day_of_week
      start_hour_utc     = patch_schedule.value.start_hour_utc
      maintenance_window = patch_schedule.value.maintenance_window
    }
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

  min_tls_version = "TLS1_2"

  tags = merge(local.default_tags, var.extra_tags)
}
