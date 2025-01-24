data "azurecaf_name" "redis" {
  name          = var.stack
  resource_type = "azurerm_redis_cache"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "data_storage" {
  name          = var.stack
  resource_type = "azurerm_storage_account"
  prefixes      = compact([local.name_prefix, "redis"])
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "redis_fw_rule" {
  for_each = local.allowed_cidrs

  name          = var.stack
  resource_type = "azurerm_redis_firewall_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, each.key])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}
