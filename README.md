# Azure Redis Cache
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/redis/azurerm/)

This Terraform module creates a [Redis Cache](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview) instance along with
[firewall rules](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-configure#firewall).
No logging is available from this resource.

The default configuration is an highly available [cluster of 3 shards](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-clustering)
and [data persistence enabled](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-persistence)
on the [Premium tier](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-premium-tier-intro).

## Version compatibility

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 5.x.x       | 0.15.x & 1.0.x    | >= 2.0          |
| >= 4.x.x       | 0.13.x            | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

You can use this module by including it this way:
```hcl
module "azure-region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  azure_region = module.azure-region.location
  client_name  = var.client_name
  environment  = var.environment
  stack        = var.stack
}

module "redis" {
  source  = "claranet/redis/azurerm"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  location            = module.azure-region.location
  location_short      = module.azure-region.location_short
  resource_group_name = module.rg.resource_group_name
  stack               = var.stack

  authorized_cidrs = {
    ip1 = "1.2.3.4/32"
    ip2 = "5.6.7.8/16"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| azurerm | >= 1.44 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_redis_firewall_rule.redis_fw_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_firewall_rule) | resource |
| [azurerm_storage_account.redis_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_non_ssl_connections"></a> [allow\_non\_ssl\_connections](#input\_allow\_non\_ssl\_connections) | Activate non SSL port (6779) for Redis connection | `bool` | `false` | no |
| <a name="input_authorized_cidrs"></a> [authorized\_cidrs](#input\_authorized\_cidrs) | Map of authorized cidrs | `map(string)` | n/a | yes |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | Redis size: (Basic/Standard: 1,2,3,4,5,6) (Premium: 1,2,3,4)  https://docs.microsoft.com/fr-fr/azure/redis-cache/cache-how-to-premium-clustering | `number` | `2` | no |
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | Name of the client | `string` | n/a | yes |
| <a name="input_cluster_shard_count"></a> [cluster\_shard\_count](#input\_cluster\_shard\_count) | Number of cluster shards desired | `number` | `3` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom name of redis server | `string` | `""` | no |
| <a name="input_data_persistence_enabled"></a> [data\_persistence\_enabled](#input\_data\_persistence\_enabled) | "true" to enable data persistence. | `bool` | `true` | no |
| <a name="input_data_persistence_frequency_in_minutes"></a> [data\_persistence\_frequency\_in\_minutes](#input\_data\_persistence\_frequency\_in\_minutes) | Data persistence snapshot frequency in minutes. | `number` | `60` | no |
| <a name="input_data_persistence_max_snapshot_count"></a> [data\_persistence\_max\_snapshot\_count](#input\_data\_persistence\_max\_snapshot\_count) | Max number of data persistence snapshots. | `number` | `null` | no |
| <a name="input_data_persistence_storage_account_replication"></a> [data\_persistence\_storage\_account\_replication](#input\_data\_persistence\_storage\_account\_replication) | Replication type for the Storage Account used for data persistence. | `string` | `"LRS"` | no |
| <a name="input_data_persistence_storage_account_tier"></a> [data\_persistence\_storage\_account\_tier](#input\_data\_persistence\_storage\_account\_tier) | Replication type for the Storage Account used for data persistence. | `string` | `"Premium"` | no |
| <a name="input_data_persistence_storage_custom_name"></a> [data\_persistence\_storage\_custom\_name](#input\_data\_persistence\_storage\_custom\_name) | Custom name for the Storage Account used for Redis data persistence. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the application's environnement | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Map of extra tags | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region in which instance will be hosted | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Azure region trigram | `string` | n/a | yes |
| <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version) | The minimum TLS version | `string` | `"1.2"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Optional prefix for the generated name | `string` | `""` | no |
| <a name="input_private_static_ip_address"></a> [private\_static\_ip\_address](#input\_private\_static\_ip\_address) | The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_redis_additional_configuration"></a> [redis\_additional\_configuration](#input\_redis\_additional\_configuration) | Additional configuration for the Redis instance. Some of the keys are set automatically. See https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html#redis_configuration for full reference. | `map(string)` | `{}` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | Redis version to deploy. Allowed values are 4 or 6 | `number` | `4` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the application ressource group, herited from infra module | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Redis Cache Sku name. Can be Basic, Standard or Premium | `string` | `"Premium"` | no |
| <a name="input_stack"></a> [stack](#input\_stack) | Name of the application stack | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet within which the Redis Cache should be deployed. Changing this forces a new resource to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_redis_capacity"></a> [redis\_capacity](#output\_redis\_capacity) | Redis capacity |
| <a name="output_redis_configuration"></a> [redis\_configuration](#output\_redis\_configuration) | Redis configuration |
| <a name="output_redis_family"></a> [redis\_family](#output\_redis\_family) | Redis family |
| <a name="output_redis_hostname"></a> [redis\_hostname](#output\_redis\_hostname) | Redis instance hostname |
| <a name="output_redis_id"></a> [redis\_id](#output\_redis\_id) | Redis instance id |
| <a name="output_redis_name"></a> [redis\_name](#output\_redis\_name) | Redis instance name |
| <a name="output_redis_port"></a> [redis\_port](#output\_redis\_port) | Redis instance port |
| <a name="output_redis_primary_access_key"></a> [redis\_primary\_access\_key](#output\_redis\_primary\_access\_key) | Redis primary access key |
| <a name="output_redis_private_static_ip_address"></a> [redis\_private\_static\_ip\_address](#output\_redis\_private\_static\_ip\_address) | Redis private static IP address |
| <a name="output_redis_secondary_access_key"></a> [redis\_secondary\_access\_key](#output\_redis\_secondary\_access\_key) | Redis secondary access key |
| <a name="output_redis_sku_name"></a> [redis\_sku\_name](#output\_redis\_sku\_name) | Redis SKU name |
| <a name="output_redis_ssl_port"></a> [redis\_ssl\_port](#output\_redis\_ssl\_port) | Redis instance SSL port |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure service documentation: [docs.microsoft.com/en-us/azure/azure-cache-for-redis/](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/)
