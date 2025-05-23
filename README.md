# Azure Redis Cache
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/redis/azurerm/)

This Terraform module creates a [Redis Cache](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview) instance along with
[firewall rules](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-configure#firewall).
No logging is available from this resource.

The default configuration is an highly available [cluster of 3 shards](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-clustering)
and [data persistence enabled](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-persistence)
on the [Premium tier](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-premium-tier-intro).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "redis" {
  source  = "claranet/redis/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  stack          = var.stack

  resource_group_name = module.rg.name

  allowed_cidrs = ["1.2.3.4/32", "5.6.7.8/16"]

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_redis_cache.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_redis_firewall_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_firewall_rule) | resource |
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurecaf_name.data_storage](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.redis](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.redis_fw_rule](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cidrs | List of allowed CIDR ranges to access the Azure Redis Cache resource. | `any` | `[]` | no |
| capacity | Redis size: (Basic/Standard: 1,2,3,4,5,6) (Premium: 1,2,3,4)  [documentation](https://docs.microsoft.com/fr-fr/azure/redis-cache/cache-how-to-premium-clustering). | `number` | `2` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| cluster\_shard\_count | Number of cluster shards desired. | `number` | `3` | no |
| custom\_name | Custom name of Redis Server | `string` | `""` | no |
| data\_persistence\_enabled | "true" to enable data persistence. | `bool` | `true` | no |
| data\_persistence\_frequency\_in\_minutes | Data persistence snapshot frequency in minutes. | `number` | `60` | no |
| data\_persistence\_max\_snapshot\_count | Max number of data persistence snapshots. | `number` | `null` | no |
| data\_persistence\_storage\_account\_replication | Replication type for the Storage Account used for data persistence. | `string` | `"LRS"` | no |
| data\_persistence\_storage\_account\_tier | Replication type for the Storage Account used for data persistence. | `string` | `"Premium"` | no |
| data\_persistence\_storage\_custom\_name | Custom name for the Storage Account used for Redis data persistence. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be `default` if not set. | `string` | `"default"` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to associate. | `map(string)` | `{}` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| minimum\_tls\_version | The minimum TLS version. | `string` | `"1.2"` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| non\_ssl\_port\_enabled | Activate non SSL port (6779) for Redis connection. | `bool` | `false` | no |
| patch\_schedules | A list of Patch Schedule, Azure Cache for Redis patch schedule is used to install important software updates in specified time window. | <pre>list(object({<br/>    day_of_week        = string<br/>    start_hour_utc     = optional(string)<br/>    maintenance_window = optional(string)<br/>  }))</pre> | `[]` | no |
| private\_static\_ip\_address | The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created. | `string` | `null` | no |
| public\_network\_access\_enabled | Whether the Azure Redis Cache is available from public network. | `bool` | `false` | no |
| redis\_additional\_configuration | Additional configuration for the Redis instance. Some of the keys are set automatically. See [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache#redis_configuration) for full reference. | <pre>object({<br/>    aof_backup_enabled                      = optional(bool)<br/>    aof_storage_connection_string_0         = optional(string)<br/>    aof_storage_connection_string_1         = optional(string)<br/>    authentication_enabled                  = optional(bool)<br/>    active_directory_authentication_enabled = optional(bool)<br/>    maxmemory_reserved                      = optional(number)<br/>    maxmemory_delta                         = optional(number)<br/>    maxmemory_policy                        = optional(string)<br/>    data_persistence_authentication_method  = optional(string)<br/>    maxfragmentationmemory_reserved         = optional(number)<br/>    rdb_backup_enabled                      = optional(bool)<br/>    rdb_backup_frequency                    = optional(number)<br/>    rdb_backup_max_snapshot_count           = optional(number)<br/>    rdb_storage_connection_string           = optional(string)<br/>    notify_keyspace_events                  = optional(string)<br/>  })</pre> | `{}` | no |
| redis\_version | Redis version to deploy. Allowed value is only 6 for new instances since v4 deprecation. | `number` | `6` | no |
| resource\_group\_name | Resource group name. | `string` | n/a | yes |
| sku\_name | Redis Cache Sku name. Can be Basic, Standard or Premium. | `string` | `"Premium"` | no |
| stack | Project stack name. | `string` | n/a | yes |
| subnet\_id | The ID of the Subnet within which the Redis Cache should be deployed. Changing this forces a new resource to be created. | `string` | `null` | no |
| zones | A list of a one or more Availability Zones, where the Redis Cache should be allocated. | `list(number)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| capacity | Redis instance capacity. |
| configuration | Redis instance configuration. |
| family | Redis instance family. |
| hostname | Redis instance hostname. |
| id | Redis instance id. |
| module\_diagnostics | Diagnostics settings module outputs. |
| name | Redis instance name. |
| port | Redis instance port. |
| primary\_access\_key | Redis instance primary access key. |
| primary\_connection\_string | The primary connection string of the Redis instance. |
| private\_static\_ip\_address | Redis instance private static IP address. |
| resource | Redis instance object. |
| resource\_storage | Redis storage account outputs. |
| secondary\_access\_key | Redis instance secondary access key. |
| secondary\_connection\_string | The secondary connection string of the Redis instance. |
| sku\_name | Redis instance SKU name. |
| ssl\_port | Redis instance SSL port. |
| terraform\_module | Information about this Terraform module. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure service documentation: [docs.microsoft.com/en-us/azure/azure-cache-for-redis/](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/)
