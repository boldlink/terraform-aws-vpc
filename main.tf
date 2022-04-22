##############
## VPC
##############

resource "aws_vpc" "main" {
  cidr_block                           = var.cidr_block
  instance_tenancy                     = var.instance_tenancy
  ipv4_ipam_pool_id                    = var.ipv4_ipam_pool_id
  ipv4_netmask_length                  = var.ipv4_netmask_length
  ipv6_cidr_block                      = var.ipv6_cidr_block
  ipv6_ipam_pool_id                    = var.ipv6_ipam_pool_id
  ipv6_netmask_length                  = var.ipv6_netmask_length
  ipv6_cidr_block_network_border_group = var.ipv6_cidr_block_network_border_group
  enable_dns_support                   = var.enable_dns_support
  enable_dns_hostnames                 = var.enable_dns_hostnames
  enable_classiclink                   = var.enable_classiclink
  enable_classiclink_dns_support       = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block     = var.assign_generated_ipv6_cidr_block
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}


## VPC flow logs: Provides a VPC/Subnet/ENI Flow Log to capture IP traffic for a specific network interface, subnet, or VPC. Logs are sent ## to a CloudWatch Log Group or a S3 Bucket.

resource "aws_flow_log" "main" {
  vpc_id                   = aws_vpc.main.id
  traffic_type             = var.traffic_type
  eni_id                   = var.flow_log_eni_id
  iam_role_arn             = aws_iam_role.main.arn
  log_destination_type     = var.log_destination_type
  log_destination          = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.main[0].arn : aws_s3_bucket.main[0].arn
  subnet_id                = var.flow_log_subnet_id
  log_format               = var.log_format
  max_aggregation_interval = var.max_aggregation_interval
  dynamic "destination_options" {
    for_each = var.destination_options
    content {
      file_format                = lookup(destination_options.value, "file_format", null)
      hive_compatible_partitions = lookup(destination_options.value, "hive_compatible_partitions", null)
      per_hour_partition         = lookup(destination_options.value, "per_hour_partition", null)
    }
  }
}

resource "aws_cloudwatch_log_group" "main" {
  count = var.log_destination_type == "cloud-watch-logs" ? 1 : 0
  name  = "/aws/vpc/${var.name}"
}

resource "aws_s3_bucket" "main" {
  count  = var.log_destination_type == "s3" ? 1 : 0
  bucket = "${var.name}-logging-bucket"
}

resource "aws_iam_role" "main" {
  name = "${var.name}-vpc-logs-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "sts",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_iam_role_policy" "main" {
  name = "${var.name}-vpc-logs-policy"
  role = aws_iam_role.main.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:${var.region}:${var.account}:log-group:/aws/vpc/${var.name}:*"
    }
  ]
}
EOF

}

######################
##DHCP options Set
######################

resource "aws_vpc_dhcp_options" "main" {
  count                = length(var.public_subnets) > 0 ? 1 : 0
  domain_name          = var.dhcp_domain_name
  domain_name_servers  = var.domain_name_servers
  ntp_servers          = var.ntp_servers
  netbios_name_servers = var.netbios_name_servers
  netbios_node_type    = var.netbios_node_type
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

##########################################
### DHCP Options Set Association
##########################################

resource "aws_vpc_dhcp_options_association" "main" {
  count           = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = join("", aws_vpc_dhcp_options.main.*.id)
}

##########################################
## Internet Gateway
##########################################

resource "aws_internet_gateway" "main" {
  count  = length(var.public_subnets) > 0 || length(var.eks_public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

##########################################
### Publiс routes
##########################################

resource "aws_route_table" "public" {
  count            = length(var.public_subnets) > 0 || length(var.eks_public_subnets) > 0 ? 1 : 0
  vpc_id           = aws_vpc.main.id
  propagating_vgws = var.propagating_vgws
  tags = merge(
    {
      "Name"        = "${var.name}.pub.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count                  = length(var.public_subnets) > 0 || length(var.eks_public_subnets) > 0 ? 1 : 0
  route_table_id         = join("", aws_route_table.public.*.id)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = join("", aws_internet_gateway.main.*.id)
}

############################
### Public Subnets
############################

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
    var.other_tags,
  )
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = join("", aws_route_table.public.*.id)
}

##########################################
### Private routes
##########################################

resource "aws_route_table" "private" {
  count  = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.pri.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

##########################################
### Private Subnets
##########################################

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
    var.other_tags,
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
    var.other_tags,
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
    var.other_tags,
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

##########################################
### Private Route Association
##########################################

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}


###########################
###Isolated Network
###########################

resource "aws_route_table" "isolated" {
  count  = length(var.isolated_subnets) > 0 ? length(var.isolated_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.isolated.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

################################################################################
### Isolated Subnets: These are private subnets without access to the internet
################################################################################

resource "aws_subnet" "isolated" {
  count             = length(var.isolated_subnets) > 0 ? length(var.isolated_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.isolated_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.isolated.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

##########################################
### Isolated Route Association
##########################################

resource "aws_route_table_association" "isolated" {
  count          = length(var.isolated_subnets) > 0 ? length(var.isolated_subnets) : 0
  subnet_id      = element(aws_subnet.isolated.*.id, count.index)
  route_table_id = element(aws_route_table.isolated.*.id, count.index)
}

###############
# EKS networks
###############

##########################################
### Eks Subnets
##########################################

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
    var.other_tags,
  )
}

resource "aws_route_table_association" "eks_public" {
  count          = length(var.eks_public_subnets)
  subnet_id      = element(aws_subnet.eks_public.*.id, count.index)
  route_table_id = join("", aws_route_table.public.*.id)
}

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
    var.other_tags,
  )
}

resource "aws_route_table_association" "eks_private" {
  count          = length(var.eks_private_subnets) > 0 ? length(var.eks_private_subnets) : 0
  subnet_id      = element(aws_subnet.eks_private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

##########################################
### Database network
##########################################
resource "aws_route_table" "database" {
  count  = length(var.database_subnets) > 0 ? length(var.database_subnets) : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name"        = "${var.name}.db.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

############################
### Database Subnets
############################

resource "aws_subnet" "database" {
  count             = length(var.database_subnets) > 0 ? length(var.database_subnets) : 0
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.database_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = merge(
    {
      "Name"        = "${var.name}.db.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_route_table_association" "database" {
  count          = length(var.database_subnets)
  subnet_id      = element(aws_subnet.database.*.id, count.index)
  route_table_id = element(aws_route_table.database.*.id, count.index)
}

#########################
## subnet group for rds
#########################

resource "aws_db_subnet_group" "database" {
  count       = length(var.database_subnets) > 0 && var.create_database_subnet_group ? 1 : 0
  name        = lower("${var.name}-subnet-group")
  description = "${var.tag_env} database subnet group"
  subnet_ids  = aws_subnet.database[*].id
  tags = merge(
    {
      "Name"        = "${var.name}.db_sub_group.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

#################################
## subnet group for DocumentDB
#################################

resource "aws_docdb_subnet_group" "main" {
  count       = length(var.database_subnets) > 0 && var.create_docdb_subnet_group ? 1 : 0
  name        = lower("${var.name}-docdb-subnet-group")
  description = "${var.tag_env} DocumentDB subnet group"
  subnet_ids  = aws_subnet.database[*].id
  tags = merge(
    {
      "Name"        = "${var.name}.doc_db_sub_group.${count.index}"
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}
