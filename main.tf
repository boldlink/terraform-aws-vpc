/*
VPC
*/

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
    var.tags,
  )
}

/*
VPC flow logs:
Provides a VPC/Subnet/ENI Flow Log to capture IP traffic
for a specific network interface, subnet, or VPC.
Logs are sent to a CloudWatch Log Group or a S3 Bucket.
*/

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
  name  = local.log_group_name
}

resource "aws_s3_bucket" "main" {
  count  = var.log_destination_type == "s3" ? 1 : 0
  bucket = "${var.name}-logging-bucket"
}

resource "aws_iam_role" "main" {
  name = "${var.name}-vpc-logs-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "sts",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "vpc-flow-logs.${local.dns_suffix}"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.tags,
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

/*
DHCP options Set
*/
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
    var.tags,
  )
}

/*
VPC DHCP Options Set Association
*/

resource "aws_vpc_dhcp_options_association" "main" {
  count           = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main[0].id
}
