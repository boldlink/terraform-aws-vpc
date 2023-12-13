resource "aws_vpc_ipam" "main" {
  description = "Example IPV4 IPAM"
  operating_regions {
    region_name = data.aws_region.current.name
  }

  tags = merge({ Name = var.name }, var.tags)
}

resource "aws_vpc_ipam_pool" "ipv4" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.main.private_default_scope_id
  locale         = data.aws_region.current.name
  description    = "example ipv4 ipam pool"
  tags           = merge({ Name = var.name }, var.tags)
}

resource "aws_vpc_ipam_pool_cidr" "ipv4" {
  ipam_pool_id = aws_vpc_ipam_pool.ipv4.id
  cidr         = "10.0.0.0/12"
}

## VPC example with IPAM-allocated IPv4 CIDR blocks
module "ipam_v4" {
  source                 = "./../../"
  name                   = var.name
  ipv4_ipam_pool_id      = aws_vpc_ipam_pool.ipv4.id
  ipv4_netmask_length    = "16"
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
  depends_on = [
    aws_vpc_ipam.main,
    aws_vpc_ipam_pool.ipv4,
    aws_vpc_ipam_pool_cidr.ipv4,
  ]
}
