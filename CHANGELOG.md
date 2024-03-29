# XXX

Added
  * AZ-1383: Add `active_directory_authentication_enabled` to `redis_configuration` block, up AzureRM minimum version to 3.83.0

# v7.7.0 - 2023-09-29

Changed
  * AZ-1188: Bump default Redis version to 6 as v4 is being retired and no longer supports creating new instances

# v7.6.0 - 2023-09-08

Breaking
  * AZ-1153: Remove `retention_days` parameters, it must be handled at destination level now. (for reference: [Provider issue](https://github.com/hashicorp/terraform-provider-azurerm/issues/23051))

# v7.5.0 - 2023-07-07

Changed
  * AZ-1105: Change variable type `allowed_cidrs` from map to list

Added
  * AZ-1105: Add outputs for primary and secondary connection string

# v7.4.0 - 2023-06-09

Added
  * AZ-1092: Add support for variable `public_network_access_enabled`
  * AZ-1092: Change variable name `authorized_cidrs` for `allowed_cidrs`

# v7.3.0 - 2023-01-20

Added
  * AZ-981: Add support for `patch_schedules`

# v7.2.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v7.1.0 - 2022-11-10

Changed
  * AZ-901: Force minimum TLS version to 1.2 for storage account

# v7.0.0 - 2022-11-04

Breaking
  * AZ-840: Require Terraform 1.3+, bump `diagnostics-settings`

Fixed
  * AZ-883: Lint code, fix deprecated HCL syntax

# v6.0.0 - 2022-07-01

Breaking
  * AZ-717: Require Terraform 1.1+
  * AZ-717: Bump AzureRM provider version to `v3.0+`

Added
  * AZ-770: Add Terraform module info in output

# v5.0.1 - 2022-06-23

Fixed
  * [GITHUB-3](https://github.com/claranet/terraform-azurerm-redis/pull/3): Add sensitive option to `redis_configuration` output that causes error with Terraform `v1.0+`

# v5.0.0 - 2022-03-31

Breaking
  * AZ-515: Option to use Azure CAF naming provider to name resources
  * AZ-515: Require Terraform 0.13+

Added
  * AZ-589: Add `diagnostic-settings` module
  * AZ-615: Add an option to enable or disable default tags

Changed
  * AZ-572: Revamp examples and improve CI

# v4.1.0 - 2021-09-03

Added
  * AZ-553: Module now supports redis version option

# v4.0.1 - 2021-08-27

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool

# v4.0.0 - 2021-01-18

Changed
  * AZ-398: Force lowercase on default generated name

Updated
  * AZ-273: Module now compatible terraform `v0.13+`

# v2.3.1/v3.0.0 - 2020-07-31

Updated
  * AZ-224: Module both compatible provider 1.x+ and 2.x+

# v2.3.0 - 2020-06-28

Updated
  * [GITHUB-1](https://github.com/claranet/terraform-azurerm-redis/pull/1): Update default tls version to `1.2`

# v2.2.0 - 2020-04-06

Breaking
  * AZ-220: Use `for_each` on firewall rules

Fixed
  * AZ-219: Ignore perpetual change on storage connection string

Added
  * AZ-217: Add parameter to modify TLS version

# v2.1.0 - 2020-03-26

Added
  * AZ-212: Additional outputs

Updated
  * AZ-206: Pin version AzureRM to be usable with version < 2


# v2.0.0 - 2019-10-15

Added
  * AZ-19: First release
