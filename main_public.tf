

/*
Internet Gateway
*/

resource "aws_internet_gateway" "main" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

/*
Publiс routes
*/

resource "aws_route_table" "public" {
  count            = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id           = aws_vpc.main.id
  propagating_vgws = var.propagating_vgws
  tags = merge(
    {
      "Name"        = "${var.name}.pub.${count.index}"
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count                  = length(var.public_subnets) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main[0].id
}

/*
Public Subnets
*/

resource "aws_subnet" "public" {
  count                           = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = element(var.public_subnets, count.index)
  availability_zone               = element(var.availability_zones, count.index)
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  tags = merge(
    {
      "Name"        = "${var.name}.pub.${count.index}"
      "Environment" = var.tag_env
    },
    var.tags,
  )
}

/*
Public Route Association
*/

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}
