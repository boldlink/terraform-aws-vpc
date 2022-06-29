/*
Private routes
*/

resource "aws_route_table" "private" {
  count  = length(var.cidrs) > 0 ? length(var.cidrs) : 0
  vpc_id = var.vpc_id
  tags = merge(
    {
      "Name" = "${var.vpc_name}.${var.name}.pri.${count.index}"
    },
    var.tags,
  )
}

/*
Private Subnets
*/
resource "aws_subnet" "private" {
  count      = length(var.cidrs) > 0 ? length(var.cidrs) : 0
  vpc_id     = var.vpc_id
  cidr_block = element(var.cidrs, count.index)
  # ipv6_cidr_block = element(var.ipv6_cidrs, count.index)
  # assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  availability_zone = element(var.availability_zone, count.index)
  tags = merge(
    {
      "Name" = "${var.vpc_name}.${var.name}.pri.${count.index}"
    },
    var.tags,
  )
}

/*
Private Route Association
*/
resource "aws_route_table_association" "private" {
  count          = length(var.cidrs) > 0 ? length(var.cidrs) : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route" "private_nat_gateway" {
  count                  = var.nat_gateway_ids == [] ? 0 : length(var.cidrs)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(var.nat_gateway_ids, count.index)
}
