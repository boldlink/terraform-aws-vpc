locals {
  public1_subnets     = [cidrsubnet(var.cidr_block, 8, 1), cidrsubnet(var.cidr_block, 8, 2), cidrsubnet(var.cidr_block, 8, 3)]
  eks_public_subnets  = [cidrsubnet(var.cidr_block, 8, 4), cidrsubnet(var.cidr_block, 8, 5), cidrsubnet(var.cidr_block, 8, 6)]
  private1_subnets    = [cidrsubnet(var.cidr_block, 8, 7), cidrsubnet(var.cidr_block, 8, 8), cidrsubnet(var.cidr_block, 8, 9)]
  eks_private_subnets = [cidrsubnet(var.cidr_block, 8, 10), cidrsubnet(var.cidr_block, 8, 11), cidrsubnet(var.cidr_block, 8, 12)]
  database_subnets    = [cidrsubnet(var.cidr_block, 8, 13), cidrsubnet(var.cidr_block, 8, 14), cidrsubnet(var.cidr_block, 8, 15)]
  redshift_subnets    = [cidrsubnet(var.cidr_block, 8, 16), cidrsubnet(var.cidr_block, 8, 17), cidrsubnet(var.cidr_block, 8, 18)]
  override_azs        = ["${data.aws_region.current.id}a", "${data.aws_region.current.id}a", "${data.aws_region.current.id}a"]
  region              = data.aws_region.current.id
  account_id          = data.aws_caller_identity.current.account_id
}
