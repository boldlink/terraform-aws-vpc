variable "name" {
  description = "The private subnet name"
  type        = string
}

variable "cidrs" {
  description = "Private subnet ipv4 CIDR list"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID to associate with"
  type        = string
}

# variable "ipv6_cidrs" {
#   description = "Private subnet ipv4 CIDR list"
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

variable "nat_gateway_ids" {
  description = "The internet gateway ID(s) to use on the route of the public internet traffic"
  type        = list(string)
}

variable "availability_zone" {
  description = "The AZs to use to assign each subnet to"
  type        = list(string)
  default     = []
}

variable "vpc_name" {
  description = "This value is used by the private subnets module to make it easier to search for the nat gateways through a specific tag"
  type        = string
  default     = null
}
