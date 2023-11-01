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

#### Example of S3 destination


module "vpc_logs_bucket" {
  source  = "boldlink/s3/aws"
  version = "2.3.1"
  bucket = "${var.name}-logs-${local.region}-${local.account_id}"
  tags   = merge({ "Name" = "${var.name}-logs-${local.region}-${local.account_id}" }, var.tags)
}

module "vpc_s3" {
  source                = "./../../"
  name                  = "${var.name}-s3-destination"
  cidr_block = var.cidr_block
  assign_generated_ipv6_cidr_block = true
  ipv6_cidr_block_network_border_group = local.region
  enable_public_subnets = true
  enable_private_subnets  = true
  enable_internal_subnets = true
  public_subnets = {
    public1 = {
      cidrs                   = local.public1_subnets
      map_public_ip_on_launch = true
      assign_ipv6_address_on_creation  = true
      public_subnet_ipv6_prefixes = [1, 2, 3]
      nat                     = "multi"
    }
    eks = {
      cidrs                   = local.eks_public_subnets
      map_public_ip_on_launch = true
      assign_ipv6_address_on_creation  = true
      private_subnet_ipv6_prefixes = [4, 5, 6]
      nat                     = "multi"
    }
  }
  private_subnets = {
    private1 = {
      cidrs = local.private1_subnets
      assign_ipv6_address_on_creation  = true
      private_subnet_ipv6_prefixes = [7, 8, 9]
    }
    eks = {
      cidrs = local.eks_private_subnets
      assign_ipv6_address_on_creation  = true
      private_subnet_ipv6_prefixes = [10, 11, 12]
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
      assign_ipv6_address_on_creation  = true
      internal_subnet_ipv6_prefixes = [13, 14, 15]
    }
    redshift = {
      cidrs = local.redshift_subnets
      assign_ipv6_address_on_creation  = true
      internal_subnet_ipv6_prefixes = [16, 17, 18]
    }
  }
  # log_destination_type  = "s3"
  # logs_bucket_arn       = module.vpc_logs_bucket.arn
  # destination_options   = {
  #   file_format = "parquet"
  #   hive_compatible_partitions = true
  #   per_hour_partition = true
  # }

  tags = var.tags
}