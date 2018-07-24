resource "azurerm_redis_cache" "redis" {
  name                = "redis-${var.environment}-${var.azure_region_short}-${var.client_name}-${var.stack}-${var.redis_name}"
  location            = "${var.azure_region}"
  resource_group_name = "${var.resource_group_name}"
  capacity            = "${var.redis_capacity}"
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = "${var.redis_enable_ssl}"

  redis_configuration = {
    maxmemory_reserved            = "${var.redis_configuration["maxmemory_reserved"]}"
    maxmemory_delta               = "${var.redis_configuration["maxmemory_delta"]}"
    maxmemory_policy              = "${var.redis_configuration["maxmemory_policy"]}"
    rdb_backup_enabled            = "true"
    rdb_backup_frequency          = "${var.redis_configuration["backup_frequency"]}"
    rdb_backup_max_snapshot_count = "${var.redis_configuration["snapshot_count"]}"
    rdb_storage_connection_string = "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.redis_storage.primary_blob_endpoint};AccountName=${azurerm_storage_account.redis_storage.name};AccountKey=${azurerm_storage_account.redis_storage.primary_access_key}"
  }
}

resource "azurerm_storage_account" "redis_storage" {
  name                     = "st${var.environment}${var.client_name}${var.stack}"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.azure_region}"
  account_tier             = "${var.account_tier}"
  account_replication_type = "${var.account_replication_type}"
}
