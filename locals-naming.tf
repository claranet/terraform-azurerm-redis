locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  name         = coalesce(var.custom_name, azurecaf_name.redis.result)
  storage_name = coalesce(var.data_persistence_storage_custom_name, azurecaf_name.data_storage.result)
}
