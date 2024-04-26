output "terraform_module" {
  description = "Information about this Terraform module"
  value = {
    name       = "redis"
    provider   = "azurerm"
    maintainer = "claranet"
  }
}
