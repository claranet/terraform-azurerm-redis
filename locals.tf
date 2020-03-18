locals {
  default_tags = {
    "env"   = var.environment
    "stack" = var.stack
  }

  name_prefix = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  name        = coalesce(var.custom_name, "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-redis")

  storage_name = coalesce(
    var.data_persistence_storage_custom_name,
    substr(replace("redis${local.name_prefix}${var.stack}${var.client_name}${var.location_short}${var.environment}st", "/[._-]/", ""), 0, 24)
  )

  redis_family_map = {
    Basic    = "C",
    Standard = "C",
    Premium  = "P"
  }

  data_persistence_enabled = var.sku_name == "Premium" ? var.data_persistence_enabled : false

  default_redis_config = {
    rdb_backup_enabled            = local.data_persistence_enabled
    rdb_storage_connection_string = local.data_persistence_enabled ? join("", azurerm_storage_account.redis_storage.*.primary_blob_connection_string) : null
    rdb_backup_frequency          = local.data_persistence_enabled ? var.data_persistence_frequency_in_minutes : null
    rdb_backup_max_snapshot_count = local.data_persistence_enabled ? var.data_persistence_max_snapshot_count : null
  }
  redis_config = merge(local.default_redis_config, var.redis_additional_configuration)
}
