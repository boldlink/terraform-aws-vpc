variable "name" {
  description = "The public subnet name"
  type        = string
}

variable "cidrs" {
  description = "Public subnet ipv4 CIDR list"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID to associate with"
  type        = string
}

variable "propagating_vgws" {
  description = "(Optional) A list of virtual gateways for propagation."
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "Set the standard behavior for public ip assignement on ec2 launch, for public subnets the default should be true"
  type        = bool
  default     = true
}

# variable "ipv6_cidrs" {
#   description = "Public subnet ipv4 CIDR list"
#   type        = list(string)
#   default     = null
# }

# variable "assign_ipv6_address_on_creation" {
#   description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false"
#   type        = bool
#   default     = false
# }

variable "tags" {
  description = "The map of tags to add to module resources"
  type        = map(string)
  default     = {}
}

variable "gateway_id" {
  description = "The internet gateway ID to use on the route of the public internet traffic"
  type        = string
}

variable "availability_zone" {
  description = "The AZs to use to assign each subnet to"
  type        = list(string)
}

variable "nat" {
  description = "Set your NatGw type, acceptable values are `single` for 1x NatGw only in a single AZ or `multi` for multiple NatGw's one per subnet"
  type        = string
  default     = null
  validation {
    condition     = var.nat == "single" || var.nat == "multi" || var.nat == null
    error_message = "Error: var.nat accepted values are null (default); single (one Nat Gateway attached to the first public subnet) or multi (one Nat Gateway per public subnet)."
  }
}

variable "vpc_name" {
  description = "This value is used by the private subnets module to make it easier to search for the nat gateways through a specific tag"
  type        = string
  default     = null
}
