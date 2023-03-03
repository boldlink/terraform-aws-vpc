module "single_nat_vpc" {
  source                 = "./../../"
  name                   = var.name
  cidr_block             = var.cidr_block
  enable_public_subnets  = true
  enable_private_subnets = true
  tags                   = var.tags

  public_subnets = {
    public = {
      cidrs                   = local.public_subnets
      map_public_ip_on_launch = true
      nat                     = "single"
    }
  }

  private_subnets = {
    private = {
      cidrs = local.private_subnets
    }
  }
}
