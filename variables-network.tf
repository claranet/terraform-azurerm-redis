variable "public_network_access_enabled" {
  description = "Whether the Azure Redis Cache is available from public network."
  type        = bool
  default     = false
}

variable "allowed_cidrs" {
  description = "List of allowed CIDR ranges to access the Azure Redis Cache resource."
  type        = any
  default     = []
  validation {
    condition     = can(tomap(var.allowed_cidrs)) || can(tolist(var.allowed_cidrs))
    error_message = "The `allowed_cidrs` argument must either be list(string) or map(string) of CIDRs."
  }

}

variable "subnet_id" {
  description = "The ID of the Subnet within which the Redis Cache should be deployed. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "private_static_ip_address" {
  description = "The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created."
  type        = string
  default     = null
}
