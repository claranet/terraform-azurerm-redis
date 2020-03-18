# Azure Redis Cache
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/redis/azurerm/)

This Terraform module creates a [Redis Cache](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-overview) instance along with 
[firewall rules](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-configure#firewall).
No logging is available from this resource.

The default configuration is an highly available [cluster of 3 shards](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-clustering)
and [data persistence enabled](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-how-to-premium-persistence) 
on the [Premium tier](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/cache-premium-tier-intro).

## Requirements
 
* [AzureRM Terraform provider](https://www.terraform.io/docs/providers/azurerm/) >= 1.28

## Terraform version compatibility
 
| Module version | Terraform version |
|----------------|-------------------|
| >= 2.x.x       | 0.12.x            |
| < 2.x.x        | 0.11.x            |

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

  authorized_cidrs = ["1.2.3.4/32", "5.6.7.8/16"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allow\_non\_ssl\_connections | Activate non SSL port (6779) for Redis connection | `bool` | `false` | no |
| authorized\_cidrs | List of authorized cidrs | `list(string)` | n/a | yes |
| capacity | Redis size: (Basic/Standard: 1,2,3,4,5,6) (Premium: 1,2,3,4)  https://docs.microsoft.com/fr-fr/azure/redis-cache/cache-how-to-premium-clustering | `number` | `2` | no |
| client\_name | Name of the client | `string` | n/a | yes |
| cluster\_shard\_count | Number of cluster shards desired | `number` | `3` | no |
| custom\_name | Custom name of redis server | `string` | `""` | no |
| data\_persistence\_enabled | "true" to enable data persistence. | `bool` | `true` | no |
| data\_persistence\_frequency\_in\_minutes | Data persistence snapshot frequency in minutes. | `number` | `60` | no |
| data\_persistence\_max\_snapshot\_count | Max number of data persistence snapshots. | `string` | n/a | yes |
| data\_persistence\_storage\_account\_replication | Replication type for the Storage Account used for data persistence. | `string` | `"LRS"` | no |
| data\_persistence\_storage\_account\_tier | Replication type for the Storage Account used for data persistence. | `string` | `"Premium"` | no |
| data\_persistence\_storage\_custom\_name | Custom name for the Storage Account used for Redis data persistence. | `string` | `""` | no |
| environment | Name of the application's environnement | `string` | n/a | yes |
| extra\_tags | Map of extra tags | `map(string)` | `{}` | no |
| location | Azure region in which instance will be hosted | `string` | n/a | yes |
| location\_short | Azure region trigram | `string` | n/a | yes |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| private\_static\_ip\_address | The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created. | `string` | n/a | yes |
| redis\_additional\_configuration | Additional configuration for the Redis instance. Some of the keys are set automatically. See https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html#redis_configuration for fulle referece | `map(string)` | `{}` | no |
| resource\_group\_name | Name of the application ressource group, herited from infra module | `string` | n/a | yes |
| sku\_name | Redis Cache Sku name. Can be Basic, Standard or Premium | `string` | `"Premium"` | no |
| stack | Name of the application stack | `string` | n/a | yes |
| subnet\_id | The ID of the Subnet within which the Redis Cache should be deployed. Changing this forces a new resource to be created. | `string` | n/a | yes |

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

## Related documentation
 
Terraform resource documentation: [www.terraform.io/docs/providers/azurerm/r/redis_cache.html](https://www.terraform.io/docs/providers/azurerm/r/redis_cache.html)
 
Microsoft Azure service documentation: [docs.microsoft.com/en-us/azure/azure-cache-for-redis/](https://docs.microsoft.com/en-us/azure/azure-cache-for-redis/)
