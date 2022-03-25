##############
## Single NAT
##############

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

locals {
  name           = "boldlink-test"
  cidr_block     = "10.0.0.0/16"
  tag_env        = "dev"
  public_subnet1 = cidrsubnet(local.cidr_block, 8, 50)
  public_subnet2 = cidrsubnet(local.cidr_block, 8, 55)
  public_subnet3 = cidrsubnet(local.cidr_block, 8, 60)
  public_subnets = [local.public_subnet1, local.public_subnet2, local.public_subnet3]

  private_subnet1 = cidrsubnet(local.cidr_block, 8, 20)
  private_subnet2 = cidrsubnet(local.cidr_block, 8, 25)
  private_subnet3 = cidrsubnet(local.cidr_block, 8, 30)
  private_subnets = [local.private_subnet1, local.private_subnet2, local.private_subnet3]

  az1 = data.aws_availability_zones.available.names[0]
  az2 = data.aws_availability_zones.available.names[1]
  az3 = data.aws_availability_zones.available.names[2]
  azs = [local.az1, local.az2, local.az3]
}

module "multiple_nat_vpc" {
  source                  = "./../.."
  name                    = local.name
  account                 = data.aws_caller_identity.current.account_id
  region                  = data.aws_region.current.name
  tag_env                 = local.tag_env
  cidr_block              = local.cidr_block
  enable_dns_support      = true
  enable_dns_hostnames    = true
  public_subnets          = local.public_subnets
  private_subnets         = local.private_subnets
  availability_zones      = local.azs
  map_public_ip_on_launch = true
  create_nat_gateway      = true
  nat_multi_az            = true
}

output "outputs" {
  value = [
    module.multiple_nat_vpc,
  ]
}
