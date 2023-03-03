module "complete_vpc" {
  source                  = "./../../"
  name                    = var.name
  cidr_block              = var.cidr_block
  enable_dns_support      = true
  enable_dns_hostnames    = true
  enable_public_subnets   = true
  enable_private_subnets  = true
  enable_internal_subnets = true
  tags                    = var.tags

  public_subnets = {
    public1 = {
      cidrs                   = local.public1_subnets
      map_public_ip_on_launch = true
      nat                     = "multi"
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
}
