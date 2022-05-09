/*
Private routes
*/

resource "aws_route_table" "private" {
  count  = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.pri.${count.index}"
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

/*
Private Subnets
*/

resource "aws_subnet" "private" {
  count             = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.pri.${count.index}"
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

####################
# EIP for NAT Gateway
####################

resource "aws_eip" "single_az" {
  count = var.create_nat_gateway && var.nat_single_az && var.nat_multi_az == false ? 1 : 0
  vpc   = true
}

resource "aws_eip" "multi_az" {
  count = var.create_nat_gateway && var.nat_multi_az && var.nat_single_az == false ? length(var.private_subnets) : 0
  vpc   = true
}

####################
# NAT Gateway
####################

resource "aws_nat_gateway" "single_az" {
  count         = var.create_nat_gateway && var.nat_single_az && var.nat_multi_az == false ? 1 : 0
  allocation_id = aws_eip.single_az[0].id
  subnet_id     = aws_subnet.public[0].id
  tags = merge(
    {
      "Name"        = "${var.name}.natG.${count.index}"
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "multi_az" {
  count         = var.create_nat_gateway && var.nat_multi_az && var.nat_single_az == false ? length(var.private_subnets) : 0
  allocation_id = element(aws_eip.multi_az.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.natG.${count.index}"
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

resource "aws_route" "private_single_az_nat_gateway" {
  count                  = var.create_nat_gateway && var.nat_single_az && var.nat_multi_az == false ? length(var.private_subnets) : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.single_az[0].id
}

resource "aws_route" "private_multi_az_nat_gateway" {
  count                  = var.create_nat_gateway && var.nat_multi_az && var.nat_single_az == false ? length(var.private_subnets) : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.multi_az[*].id, count.index)
}

/*
Private Route Association
*/

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
