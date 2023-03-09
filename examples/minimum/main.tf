locals {
  public_subnets = [cidrsubnet(var.cidr_block, 8, 1), cidrsubnet(var.cidr_block, 8, 2), cidrsubnet(var.cidr_block, 8, 3)]
}

module "minimum_vpc" {
  source                = "./../../"
  name                  = var.name
  cidr_block            = var.cidr_block
  enable_public_subnets = true
  tags                  = var.tags

  public_subnets = {
    public = {
      cidrs                   = local.public_subnets
      map_public_ip_on_launch = true
    }
  }
}
