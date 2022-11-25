locals {
  cidr_block       = "10.1.0.0/16"
  public1_subnets  = [cidrsubnet(local.cidr_block, 8, 1), cidrsubnet(local.cidr_block, 8, 2), cidrsubnet(local.cidr_block, 8, 3)]
  private1_subnets = [cidrsubnet(local.cidr_block, 8, 4), cidrsubnet(local.cidr_block, 8, 5), cidrsubnet(local.cidr_block, 8, 6)]
}

module "single_nat_vpc" {
  source                 = "./../../"
  name                   = "single-nat-vpc-example"
  cidr_block             = local.cidr_block
  enable_public_subnets  = true
  enable_private_subnets = true
  public_subnets = {
    public1 = {
      cidrs = local.public1_subnets
      nat   = "single"
    }
  }
  private_subnets = {
    private1 = {
      cidrs = local.private1_subnets
    }
  }

  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform"
    department         = "operations"
    Instance_Scheduler = true
    Layer_Name         = "c300-aws-vpc"
    Layer_Id           = "c300"
  }
}
