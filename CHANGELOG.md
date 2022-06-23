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
