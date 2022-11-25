locals {
  cidr_block      = "10.1.0.0/16"
  public1_subnets = [cidrsubnet(local.cidr_block, 8, 1), cidrsubnet(local.cidr_block, 8, 2), cidrsubnet(local.cidr_block, 8, 3)]
}

module "minimum_vpc" {
  source                = "./../../"
  name                  = "minimum-vpc-example"
  cidr_block            = local.cidr_block
  enable_public_subnets = true
  public_subnets = {
    public1 = {
      cidrs = local.public1_subnets
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
