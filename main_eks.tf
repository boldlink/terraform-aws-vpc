/*
Eks Public Subnets
*/

resource "aws_subnet" "eks_public" {
  count                   = length(var.eks_public_subnets) > 0 ? length(var.eks_public_subnets) : 0
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.eks_public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = merge(
    {
      "Name"                                      = "${var.name}.eks.pub.${count.index}"
      "Environment"                               = var.tag_env
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/elb"                    = "1"
    },
    var.tags,
  )
}

/*
Eks Public Route Association
*/

resource "aws_route_table_association" "eks_public" {
  count          = length(var.eks_public_subnets)
  subnet_id      = element(aws_subnet.eks_public.*.id, count.index)
  route_table_id = aws_route_table.public[0].id
}

/*
EKS Subnets
*/

resource "aws_subnet" "eks_private" {
  count             = length(var.eks_private_subnets) > 0 ? length(var.eks_private_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.eks_private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(
    {
      "Name"                                      = "${var.name}.eks.pri.${count.index}"
      "Environment"                               = var.tag_env
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/internal-elb"           = "1"
    },
    var.tags,
  )
}

resource "aws_route_table_association" "eks_private" {
  count          = length(var.eks_private_subnets) > 0 ? length(var.eks_private_subnets) : 0
  subnet_id      = element(aws_subnet.eks_private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
