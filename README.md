### Prerequisites

* module.infra.resource_group_name: "git::ssh://git@bitbucket.org/morea/terraform.feature.azurerm.basic.infra.git?ref=v1.0.0"
* module.az-region.location|location-short: "git::ssh://git@bitbucket.org/morea/terraform.modules.azurerm.regions.git?ref=v1.0.0"

### Optionnal
if **datadog_integration** = true 
Set the correct tags on instance  --> git::ssh://git@bitbucket.org/morea/terraform.feature.datadog.git//cloud/azure/redis

### Module declaration

Terraform module declaration example:
```
module "redis" {
  source = "git::ssh://git@bitbucket.org/morea/terraform.feature.azure.redis.git?ref=XXXXX"
  client_name         = "${var.client_name}"
  azure_region        = "${module.az-region.location}"
  azure_region_short  = "${module.az-region.location-short}"
  environment         = "${var.environment}"
  stack               = "${var.stack}"
  resource_group_name = "${module.infra.resource_group_name}"
  authorized_cidrs    = "${var.authorized_cidrs}"

  redis_name          = "${var.redis_name}"
  redis_enable_ssl    = "${var.redis_enable_ssl}"
  redis_configuration = "${var.redis_configuration}" #Example to enable backup : {rdb_backup_frequency = "60", rdb_backup_max_snapshot_count = "1"}, if omitted, redis instance will not be created

# If you want to choose the number of shard
# redis_shard_count   = "2"

# Enable cluster feature
# cluster_enabled     = "1"

# Enable backup feature
# backup_enabled      = "1"

# Enable datadog monitoring tags
# datadog_integration = "true"
  custom_tags         = {dd_test_monitoring = "enabled"}
}

```

### Module profile

If you need to configure a :

* **redis-backup** --> set **redis_backup_enabled = "1"** and add in the configuration block **"rdb_backup_frequency"** **"rdb_backup_max_snapshot_count"**
* **redis-cluster** --> set **redis_cluster_enabled = "1"** and set the number of desired shard **redis_shard_count** (default 3)
* **redis-cluster-backup** --> set **redis_cluster_enabled = "1"** and **redis_backup_enabled = "1"** , add in the configuration block **"rdb_backup_frequency"** **"rdb_backup_max_snapshot_count"** and set desired shard **redis_shard_count** (default 3)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account_replication_type | Type of storage replication : LRS,GRS,RAGRS,ZRS https://docs.microsoft.com/fr-fr/azure/storage/common/storage-redundancy | string | `GRS` | no |                
| account_tier | Storage account for backup policy | string | `Standard` | no |
| authorized_cidrs | List of authorized cidrs, must be provided using remote states cloudpublic/cloudpublic/global/vars/terraform.state --> authorized_cidrs | list | - | yes |              
| azure_region | Azure region in which instance will be hosted | string | - | yes |
| azure_region_short | Azure region trigram | string | - | yes |
| client_name | Name of client | string | - | yes |
| custom_tags | Map of custom tags | map | `<map>` | no |
| datadog_integration | Enable datadog tags --> true/false | string | `false` | no |
| environment | Name of application's environnement | string | - | yes |
| redis_backup_enabled | Enable backup feature --> 0 (disabled) 1 (enabled) | string | `0` | no |                                                                                            
| redis_capacity | Redis size: (Basic/Standard: 1,2,3,4,5,6) (Premium: 1,2,3,4)  https://docs.microsoft.com/fr-fr/azure/redis-cache/cache-how-to-premium-clustering | string | `2` | no |    
| redis_cluster_enabled | Enable cluster feature --> 0 (disabled) 1 (enabled) | string | `0` | no |                                                                                          
| redis_configuration | Set of redis configuration, accepted parameters: maxmemory_reserved (default: 10), maxmemory_delta (default: 2), maxmemory_policy (default: allkeys-lru), backup_frequency, snapshot_count | map | `<map>` | no |
| redis_enable_ssl | Activate Ssl port (6789) of Redis instance | string | `false` | no |
| redis_family | Sku family C=Basic/Standard, P=Premium | string | `C` | no |
| redis_name | Redis instance name | string | - | yes |
| redis_shard_count | Number of shard wanted in case of cluster setup | string | `3` | no |
| redis_sku_name | Sku name: Basic, Standard, Premium | string | `Standard` | no |
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

