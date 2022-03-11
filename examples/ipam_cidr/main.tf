data "aws_region" "current" {}

resource "aws_vpc_ipam" "main" {
  operating_regions {
    region_name = data.aws_region.current.name
  }
}

resource "aws_vpc_ipam_pool" "main" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.main.private_default_scope_id
  locale         = data.aws_region.current.name
}

resource "aws_vpc_ipam_pool_cidr" "main" {
  ipam_pool_id = aws_vpc_ipam_pool.main.id
  cidr         = "172.5.0.0/16"
}

module "aws_vpc" {
  source               = "./../.."
  enable_dns_support   = true
  enable_dns_hostnames = true
  ipv4_ipam_pool_id    = aws_vpc_ipam_pool.main.id
  ipv4_netmask_length  = 28
  depends_on = [
    aws_vpc_ipam_pool_cidr.main
  ]
  tags = {
    Name        = "boldlink-test"
    Environment = "Dev"
  }
}

output "outputs" {
  value = [
    module.aws_vpc,
  ]
}
