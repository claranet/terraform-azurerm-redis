## 8.0.0 (2025-01-24)

### ⚠ BREAKING CHANGES

* **AZ-1088:** module v8 structure and updates

### Features

* **AZ-1088:** module v8 structure and updates 0168f5d

### Miscellaneous Chores

* **deps:** update dependency claranet/diagnostic-settings/azurerm to v7 15d2aa9
* **deps:** update dependency opentofu to v1.8.3 f54e3c1
* **deps:** update dependency opentofu to v1.8.4 c06d021
* **deps:** update dependency opentofu to v1.8.6 f79312d
* **deps:** update dependency opentofu to v1.8.8 65511cd
* **deps:** update dependency opentofu to v1.9.0 dbca72a
* **deps:** update dependency pre-commit to v4 e7ede9e
* **deps:** update dependency pre-commit to v4.0.1 4ac57fa
* **deps:** update dependency pre-commit to v4.1.0 02fbb24
* **deps:** update dependency tflint to v0.54.0 c574db9
* **deps:** update dependency tflint to v0.55.0 b2956ab
* **deps:** update dependency trivy to v0.56.0 92096ab
* **deps:** update dependency trivy to v0.56.1 457c516
* **deps:** update dependency trivy to v0.56.2 21bcbc6
* **deps:** update dependency trivy to v0.57.1 e573301
* **deps:** update dependency trivy to v0.58.1 b46a002
* **deps:** update dependency trivy to v0.58.2 6f55d9e
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 5aa10dc
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 2a728af
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 c2e4a89
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 f824f1f
* **deps:** update tools a87f8ce
* **deps:** update tools 043da56
* prepare for new examples structure 47c3334
* update examples structure 19d4308
* update tflint config for v0.55.0 de6bbcf

## 7.9.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 3796499

### Documentation

* update README badge to use OpenTofu registry 31fbc21
* update README with `terraform-docs` v0.19.0 80fe29b

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.7.0 d0f845f
* **deps:** update dependency opentofu to v1.7.1 e158dbe
* **deps:** update dependency opentofu to v1.7.2 cffdd40
* **deps:** update dependency opentofu to v1.7.3 98356c0
* **deps:** update dependency opentofu to v1.8.0 fb116da
* **deps:** update dependency opentofu to v1.8.1 bdb9e02
* **deps:** update dependency pre-commit to v3.7.1 46df252
* **deps:** update dependency pre-commit to v3.8.0 42faa49
* **deps:** update dependency terraform-docs to v0.18.0 ba73327
* **deps:** update dependency terraform-docs to v0.19.0 7fd97b8
* **deps:** update dependency tflint to v0.51.0 99bc9f5
* **deps:** update dependency tflint to v0.51.1 86836c2
* **deps:** update dependency tflint to v0.51.2 1c7eb89
* **deps:** update dependency tflint to v0.52.0 9749244
* **deps:** update dependency tflint to v0.53.0 3561a8a
* **deps:** update dependency trivy to v0.51.0 bc9cdc7
* **deps:** update dependency trivy to v0.51.1 6bb45d4
* **deps:** update dependency trivy to v0.51.2 cc69d4c
* **deps:** update dependency trivy to v0.51.4 e4c9bb5
* **deps:** update dependency trivy to v0.52.0 835980b
* **deps:** update dependency trivy to v0.52.1 bff96a5
* **deps:** update dependency trivy to v0.52.2 4eea620
* **deps:** update dependency trivy to v0.53.0 539d78a
* **deps:** update dependency trivy to v0.54.1 6d94a4e
* **deps:** update dependency trivy to v0.55.0 f2f1288
* **deps:** update dependency trivy to v0.55.1 1a85b50
* **deps:** update dependency trivy to v0.55.2 c4bdd86
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 564b4e2
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 dac04e7
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 dd7a352
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 88dacba
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 2fc0a45
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 3996262
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 98b57a1
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 f949cb7
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 a208088
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 494a4ca
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 dc2120a
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 1c34ad9
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 12017df
* **deps:** update tools 0b6c620

## 7.8.1 (2024-04-26)


### Styles

* **output:** remove unused version from outputs-module fa17b7b


### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] 5f52b5f
* **AZ-1391:** update semantic-release config [skip ci] 9e25e07


### Miscellaneous Chores

* **deps:** enable automerge on renovate a129321
* **deps:** update dependency trivy to v0.50.2 4da1fa2
* **deps:** update dependency trivy to v0.50.4 978dab2
* **pre-commit:** update commitlint hook c6a9740
* **release:** remove legacy `VERSION` file f074b0a

# v7.8.0 - 2024-03-29

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
