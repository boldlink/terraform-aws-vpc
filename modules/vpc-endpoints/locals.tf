locals {
  vpc_name       = data.aws_vpc.main.tags.Name
  vpc_cidr_block = data.aws_vpc.main.cidr_block
  vpc_id         = data.aws_vpc.main.id
}
