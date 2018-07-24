### Prerequisites
module.infra.resource_group_name: "git::ssh://git@bitbucket.org/morea/terraform.feature.azurerm.basic.infra.git?ref=v1.0.0"
module.az-region.location|location-short: "git::ssh://git@bitbucket.org/morea/terraform.modules.azurerm.regions.git?ref=v1.0.0"

### Information
*redis_sku_name* and *redis_family* are set to "Premium" automatically.
It is required for cluster feature.

*redis_shard_count*  is set to 3 by default.

### Module declaration

Terraform module declaration example:
```
module "redis" {
  source = "git::ssh://git@bitbucket.org/morea/terraform.feature.azure.redis.git//redis-cluster"
  client_name              = "${var.client_name}"
  azure_region             = "${module.az-region.location}"
  azure_region_short       = "${module.az-region.location-short}"
  environment              = "${var.environment}"
  stack                    = "${var.stack}"
  resource_group_name      = "${module.infra.resource_group_name}"

  redis_name               = "${var.redis_name}"
  redis_capacity           = "${var.redis_capacity}"
  redis_enable_ssl         = "${var.redis_enable_ssl}"
  redis_configuration      = "${var.redis_configuration}" # Example [{rdb_backup_enabled = "false", rdb_backup_frequency = "60", rdb_backup_max_snapshot_count = "7"}]

  admin_cidrs              = "${var.admin_cidrs}"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_cidrs | List of authorized cidrs, must be provided using remote states cloudpublic/cloudpublic/global/vars/terraform.state --> admin_cidrs | list | - | yes |
| azure_region | Azure region in which instance will be hosted | string | - | yes |
| azure_region_short | Azure region trigram | string | - | yes |
| client_name | Name of client | string | - | yes |
| environment | Name of application's environnement | string | - | yes |
| redis_capacity | Redis size: (Basic/Standard: 1,2,3,4,5,6) (Premium: 1,2,3,4)  https://docs.microsoft.com/fr-fr/azure/redis-cache/cache-how-to-premium-clustering | string | `2` | no |
| redis_configuration | Set of redis configuration, accepted parameters: maxmemory_reserved (default: 200), maxmemory_delta (default: 200), maxmemory_policy (default: allkeys-lru), backup_frequency (default: 60), snapshot_count (default: 1) | map | `<map>` | no |
| redis_enable_ssl | Activate Ssl port (6789) of Redis instance | string | `false` | no |
| redis_name | Redis instance name | string | - | yes |
| redis_shard_count | For clustering, number of desired shard | string | `3` | no |
| resource_group_name | Name of the application ressource group, herited from infra module | string | - | yes |
| stack | Name of application stack | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| redis_hostname | Redis instance hostname |
| redis_id | Redis instance id |
| redis_port | Redis instance port |
| redis_primary_access_key | Redis primary access key |
| redis_secondary_access_key | Redis secondary access key |
| redis_ssl_port | Redis instance SSL port |

More information about azure redis class: https://azure.microsoft.com/fr-fr/pricing/details/cache/
