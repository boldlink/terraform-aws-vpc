module "aws_vpc" {
  source               = "./../.."
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
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
