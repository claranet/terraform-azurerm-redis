# Basic Redis
resource "azurerm_redis_cache" "redis" {
  name                = "redis-${var.environment}-${var.location_short}-${var.client_name}-${var.stack}-${var.redis_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  capacity = "${var.redis_capacity}"
  family   = "${signum(var.redis_cluster_enabled + var.redis_backup_enabled) == "1" ? "P" : var.redis_family }"
  sku_name = "${signum(var.redis_cluster_enabled + var.redis_backup_enabled) == "1" ? "Premium" : var.redis_sku_name }"

  enable_non_ssl_port = "${var.redis_enable_ssl}"
  shard_count         = "${var.redis_cluster_enabled == "1" ? var.redis_shard_count : "0" }"
  tags                = "${merge(zipmap(list("dd_monitoring","dd_azure_redis"),split(" ",var.datadog_integration == "1" ? "enabled enabled" : "disabled disabled")), map("env", var.environment, "stack", var.stack), var.custom_tags)}"

  #Prepare for terraform 0.12
  #  tags                = "${merge(var.datadog_integration == "1" ? {"dd_monitoring" = "enabled","dd_azure_redis" = "enabled"} : null), map("env", var.environment, "stack", var.stack), var.custom_tags)}"

  redis_configuration = ["${merge(var.redis_configuration,map("rdb_backup_enabled","${var.redis_backup_enabled == "1" ? "true" : "false" }", "rdb_storage_connection_string" ,"${var.redis_backup_enabled == "1" ? "DefaultEndpointsProtocol=https;BlobEndpoint=${join("",azurerm_storage_account.redis_storage.*.primary_blob_endpoint)};AccountName=${join("",azurerm_storage_account.redis_storage.*.name)};AccountKey=${join("",azurerm_storage_account.redis_storage.*.primary_access_key)}" : ""}"))}"]
}

#Prepare for terraform 0.12
#  redis_configuration = {
#    maxmemory_reserved = "${var.redis_configuration["maxmemory_reserved"]}"
#    maxmemory_delta    = "${var.redis_configuration["maxmemory_delta"]}"
#    maxmemory_policy   = "${var.redis_configuration["maxmemory_policy"]}"
#    rdb_backup_enabled = "${var.redis_backup_enabled == "1" ? "true" : "false" }"
#    rdb_backup_frequency          = "${var.redis_backup_enabled == "1" ? lookup(var.redis_configuration,"backup_frequency") : null }"
#    rdb_backup_max_snapshot_count = "${var.redis_backup_enabled == "1" ? lookup(var.redis_configuration,"snapshot_count") : null }"
#    rdb_storage_connection_string = "${var.redis_backup_enabled == "1" ? "DefaultEndpointsProtocol=https;BlobEndpoint=azurerm_storage_account.redis_storage.primary_blob_endpoint;AccountName=azurerm_storage_account.redis_storage.name;AccountKey=azurerm_storage_account.redis_storage.primary_access_key" : null }"
#  }

resource "azurerm_storage_account" "redis_storage" {
  count               = "${var.redis_backup_enabled}"
  name                = "st${var.environment}${var.client_name}${var.stack}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  account_tier             = "${var.storage_account_tier}"
  account_replication_type = "${var.storage_account_replication_type}"
}
