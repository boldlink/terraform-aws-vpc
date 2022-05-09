###################
### internal routes
###################

resource "aws_route_table" "internal" {
  count  = length(var.internal_subnets) > 0 ? length(var.internal_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.internal.${count.index}"
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

###########################################################################
# internal Subnets: These are private subnets without access to the internet
###########################################################################

resource "aws_subnet" "internal" {
  count             = length(var.internal_subnets) > 0 ? length(var.internal_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.internal_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.internal.${count.index}"
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

/*
internal Route Association
*/

resource "aws_route_table_association" "internal" {
  count          = length(var.internal_subnets) > 0 ? length(var.internal_subnets) : 0
  subnet_id      = element(aws_subnet.internal.*.id, count.index)
  route_table_id = element(aws_route_table.internal.*.id, count.index)
}
