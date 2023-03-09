variable "cidr_block" {
  type        = string
  description = "The CIDR block of the vpc"
  default     = "10.1.0.0/16"
}

variable "name" {
  type        = string
  description = "The stack name"
  default     = "single-nat-vpc-example"
}

variable "tags" {
  type        = map(string)
  description = "The resource tags to be applied"
  default = {
    Environment        = "example"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "Example"
    LayerId            = "Example"
  }
}
