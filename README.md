# Azure Redis Cache
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/redis/azurerm/)

This Terraform module creates a [Redis Cache](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview) instance along with
[firewall rules](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-configure#firewall).
No logging is available from this resource.

The default configuration is an highly available [cluster of 3 shards](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-clustering)
and [data persistence enabled](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-persistence)
on the [Premium tier](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-premium-tier-intro).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run-common/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

module "redis" {
  source  = "claranet/redis/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  authorized_cidrs = {
    ip1 = "1.2.3.4/32"
    ip2 = "5.6.7.8/16"
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2, >= 1.2.22 |
| azurerm | ~> 3.22 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | 6.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_redis_firewall_rule.redis_fw_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_firewall_rule) | resource |
| [azurerm_storage_account.redis_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurecaf_name.data_storage](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.redis](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.redis_fw_rule](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_non\_ssl\_connections | Activate non SSL port (6779) for Redis connection | `bool` | `false` | no |
| authorized\_cidrs | Map of authorized cidrs | `map(string)` | n/a | yes |
| capacity | Redis size: (Basic/Standard: 1,2,3,4,5,6) (Premium: 1,2,3,4)  https://docs.microsoft.com/fr-fr/azure/redis-cache/cache-how-to-premium-clustering | `number` | `2` | no |
| client\_name | Name of the client | `string` | n/a | yes |
| cluster\_shard\_count | Number of cluster shards desired | `number` | `3` | no |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| custom\_name | Custom name of Redis Server | `string` | `""` | no |
| data\_persistence\_enabled | "true" to enable data persistence. | `bool` | `true` | no |
| data\_persistence\_frequency\_in\_minutes | Data persistence snapshot frequency in minutes. | `number` | `60` | no |
| data\_persistence\_max\_snapshot\_count | Max number of data persistence snapshots. | `number` | `null` | no |
| data\_persistence\_storage\_account\_replication | Replication type for the Storage Account used for data persistence. | `string` | `"LRS"` | no |
| data\_persistence\_storage\_account\_tier | Replication type for the Storage Account used for data persistence. | `string` | `"Premium"` | no |
| data\_persistence\_storage\_custom\_name | Custom name for the Storage Account used for Redis data persistence. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Name of the application's environnement | `string` | n/a | yes |
| extra\_tags | Additional tags to associate. | `map(string)` | `{}` | no |
| location | Azure region in which instance will be hosted | `string` | n/a | yes |
| location\_short | Azure region trigram | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| logs\_retention\_days | Number of days to keep logs on storage account. | `number` | `30` | no |
| minimum\_tls\_version | The minimum TLS version | `string` | `"1.2"` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| private\_static\_ip\_address | The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created. | `string` | `null` | no |
| redis\_additional\_configuration | Additional configuration for the Redis instance. Some of the keys are set automatically. See https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html#redis_configuration for full reference. | `map(string)` | `{}` | no |
| redis\_version | Redis version to deploy. Allowed values are 4 or 6 | `number` | `4` | no |
| resource\_group\_name | Name of the application ressource group, herited from infra module | `string` | n/a | yes |
| sku\_name | Redis Cache Sku name. Can be Basic, Standard or Premium | `string` | `"Premium"` | no |
| stack | Name of the application stack | `string` | n/a | yes |
| subnet\_id | The ID of the Subnet within which the Redis Cache should be deployed. Changing this forces a new resource to be created. | `string` | `null` | no |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| zones | A list of a one or more Availability Zones, where the Redis Cache should be allocated. | `list(number)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| redis\_capacity | Redis capacity |
| redis\_configuration | Redis configuration |
| redis\_family | Redis family |
| redis\_hostname | Redis instance hostname |
| redis\_id | Redis instance id |
| redis\_name | Redis instance name |
| redis\_port | Redis instance port |
| redis\_primary\_access\_key | Redis primary access key |
| redis\_private\_static\_ip\_address | Redis private static IP address |
| redis\_secondary\_access\_key | Redis secondary access key |
| redis\_sku\_name | Redis SKU name |
| redis\_ssl\_port | Redis instance SSL port |
| terraform\_module | Information about this Terraform module |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure service documentation: [docs.microsoft.com/en-us/azure/azure-cache-for-redis/](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/)
