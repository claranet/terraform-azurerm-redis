locals {
  redis_family_map = {
    Basic    = "C",
    Standard = "C",
    Premium  = "P"
  }

  data_persistence_enabled = var.sku_name == "Premium" ? var.data_persistence_enabled : false

  default_redis_config = {
    rdb_backup_enabled            = local.data_persistence_enabled
    rdb_storage_connection_string = one(azurerm_storage_account.main[*].primary_blob_connection_string)
    rdb_backup_frequency          = local.data_persistence_enabled ? var.data_persistence_frequency_in_minutes : null
    rdb_backup_max_snapshot_count = local.data_persistence_enabled ? var.data_persistence_max_snapshot_count : null
  }

  redis_config = merge(local.default_redis_config, var.redis_additional_configuration)

  allowed_cidrs       = try(can(tomap(var.allowed_cidrs)) ? tomap(var.allowed_cidrs) : { for x in var.allowed_cidrs : index(var.allowed_cidrs, x) => x }, {})
  allowed_cidrs_names = try(can(tomap(var.allowed_cidrs)) ? keys(tomap(var.allowed_cidrs)) : null)
}
