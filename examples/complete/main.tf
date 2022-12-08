data "aws_region" "current" {}

locals {
  cidr_block          = "10.1.0.0/16"
  public1_subnets     = [cidrsubnet(local.cidr_block, 8, 1), cidrsubnet(local.cidr_block, 8, 2), cidrsubnet(local.cidr_block, 8, 3)]
  eks_public_subnets  = [cidrsubnet(local.cidr_block, 8, 4), cidrsubnet(local.cidr_block, 8, 5), cidrsubnet(local.cidr_block, 8, 6)]
  private1_subnets    = [cidrsubnet(local.cidr_block, 8, 7), cidrsubnet(local.cidr_block, 8, 8), cidrsubnet(local.cidr_block, 8, 9)]
  eks_private_subnets = [cidrsubnet(local.cidr_block, 8, 10), cidrsubnet(local.cidr_block, 8, 11), cidrsubnet(local.cidr_block, 8, 12)]
  database_subnets    = [cidrsubnet(local.cidr_block, 8, 13), cidrsubnet(local.cidr_block, 8, 14), cidrsubnet(local.cidr_block, 8, 15)]
  redshift_subnets    = [cidrsubnet(local.cidr_block, 8, 16), cidrsubnet(local.cidr_block, 8, 17), cidrsubnet(local.cidr_block, 8, 18)]
  override_azs        = ["${data.aws_region.current.id}a", "${data.aws_region.current.id}a", "${data.aws_region.current.id}a"]
}

module "complete_vpc" {
  source                  = "./../../"
  name                    = "complete-vpc-example"
  cidr_block              = local.cidr_block
  enable_dns_support      = true
  enable_dns_hostnames    = true
  enable_public_subnets   = true
  enable_private_subnets  = true
  enable_internal_subnets = true
  public_subnets = {
    public1 = {
      cidrs = local.public1_subnets
      #nat   = "multi"
    },
    eks = {
      cidrs = local.eks_public_subnets
      tags = {
        "kubernetes.io/cluster/<cluster-name>" = "shared" # EKS public subnets
        "kubernetes.io/role/elb"               = true     # Enable Alb controller tags for public alb/nlb
      }
    }
  }
  private_subnets = {
    private1 = {
      cidrs = local.private1_subnets
    }
    eks = {
      cidrs = local.eks_private_subnets
      tags = {
        "kubernetes.io/cluster/<cluster-name>" = "shared" # EKS private subnets
        "kubernetes.io/role/internal-elb"      = true     # Enable Alb controller tags for internal alb/nlb
      }
    }
  }
  internal_subnets = {
    databases = {
      cidrs        = local.database_subnets
      override_azs = local.override_azs # ex. Use the same AZ for high speed placement groups
    }
    redshift = {
      cidrs = local.redshift_subnets
    }
  }
  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform"
    department         = "operations"
    InstanceScheduler  = true
    LayerName          = "c300-aws-vpc"
    LayerId            = "c300"
  }
}
