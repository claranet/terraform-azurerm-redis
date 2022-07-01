output "terraform_module" {
  description = "Information about this Terraform module"
  value = {
    name       = "redis"
    version    = file("${path.module}/VERSION")
    provider   = "azurerm"
    maintainer = "claranet"
  }
}
