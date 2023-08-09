#####################
### VPC
#####################
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
  assign_generated_ipv6_cidr_block     = var.assign_generated_ipv6_cidr_block
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}

resource "aws_default_security_group" "main" {
  vpc_id = aws_vpc.main.id
}

#####################
### VPC flow logs
#####################
resource "aws_flow_log" "main" {
  vpc_id                   = aws_vpc.main.id
  traffic_type             = var.traffic_type
  eni_id                   = var.flow_log_eni_id
  log_destination_type     = var.log_destination_type
  log_destination          = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.main[0].arn : (var.log_destination_type == "s3" && var.logs_bucket_arn != null ? var.logs_bucket_arn : null)
  subnet_id                = var.flow_log_subnet_id
  log_format               = local.log_format
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = merge({ "Name" = var.name }, var.tags)

  dynamic "destination_options" {
    for_each = var.destination_options
    content {
      file_format                = lookup(destination_options.value, "file_format", null)
      hive_compatible_partitions = lookup(destination_options.value, "hive_compatible_partitions", null)
      per_hour_partition         = lookup(destination_options.value, "per_hour_partition", null)
    }
  }

  # Only create the IAM role when log_destination_type is cloud-watch-logs
  # Otherwise, set the IAM role ARN to null
  iam_role_arn = var.log_destination_type == "cloud-watch-logs" ? aws_iam_role.main[0].arn : null
}

# Create IAM role only when log_destination_type is cloud-watch-logs
resource "aws_iam_role" "main" {
  count              = var.log_destination_type == "cloud-watch-logs" ? 1 : 0
  name               = "${var.name}-flowlogs-role"
  assume_role_policy = local.vpc_assume_policy
  tags               = merge({ "Name" = "${var.name}-flowlogs-role" }, var.tags)
}

# Create the IAM policy to the IAM role when `log_destination_type` is `cloud-watch-logs`
resource "aws_iam_role_policy" "main" {
  count  = var.log_destination_type == "cloud-watch-logs" ? 1 : 0
  name   = "${var.name}-vpc-logs-policy"
  role   = aws_iam_role.main[0].id
  policy = local.vpc_role_policy
}

resource "aws_cloudwatch_log_group" "main" {
  count             = var.log_destination_type == "cloud-watch-logs" ? 1 : 0
  name              = local.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.logs_kms_key_id
  tags = merge(
    {
      "Name" = local.log_group_name
    },
    var.tags,
  )
}

#####################
## VPC Logs S3 configuration
#####################
# resource "aws_s3_bucket" "main" {
#   count  = var.log_destination_type == "s3" ? 1 : 0
#   bucket = local.logs_bucket_name
#   tags = merge(
#     {
#       "Name" = local.logs_bucket_name
#     },
#     var.tags,
#   )
# }

# resource "aws_s3_bucket_acl" "main" {
#   count  = var.log_destination_type == "s3" ? 1 : 0
#   bucket = aws_s3_bucket.main[0].id
#   acl    = "private"
# }

# resource "aws_s3_bucket_ownership_controls" "main" {
#   count  = var.log_destination_type == "s3" ? 1 : 0
#   bucket = aws_s3_bucket.main[0].id
#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }

# resource "aws_s3_bucket_policy" "main" {
#   count  = var.log_destination_type == "s3" ? 1 : 0
#   bucket = aws_s3_bucket.main[0].id
#   policy = local.vpc_s3_bucket_policy
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
# count  = var.log_destination_type == "s3" ? 1 : 0
#   bucket = aws_s3_bucket.mybucket.bucket
#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = aws_kms_key.mykey.arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "example" {
#   count                   = var.log_destination_type == "s3" ? 1 : 0
#   bucket                  = aws_s3_bucket.main[0].id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

#####################
## DHCP options Set
#####################
resource "aws_vpc_dhcp_options" "main" {
  domain_name          = var.dhcp_domain_name
  domain_name_servers  = var.domain_name_servers
  ntp_servers          = var.ntp_servers
  netbios_name_servers = var.netbios_name_servers
  netbios_node_type    = var.netbios_node_type
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}

##########################################
### VPC DHCP Options Set Association
##########################################
resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}

#####################
## Internet Gateway
#####################
resource "aws_internet_gateway" "main" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}

## SG for Interface endpoint
resource "aws_security_group" "allow_443" {
  count       = length(var.vpc_endpoints) > 0 && try(contains([for ep in var.vpc_endpoints : try(ep["endpoint_type"], null)], "Interface"), false) ? 1 : 0
  name        = "vpce.interface_endpoint.allow_443"
  description = "Allow VPC Endpoints SSL/TLS inbound traffic"
  vpc_id      = aws_vpc.main.id
  tags        = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )

  ingress {
    description = "Allow traffic for Interface VPC Endpoints"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
}

resource "aws_vpc_endpoint" "endpoint" {
  count               = length(var.vpc_endpoints) > 0 ? length(var.vpc_endpoints) : 0
  vpc_id              = aws_vpc.main.id
  service_name        = try(var.vpc_endpoints[count.index]["service_name"], null)
  auto_accept         = try(var.vpc_endpoints[count.index]["auto_accept"], null)
  policy              = try(var.vpc_endpoints[count.index]["policy"], null)
  private_dns_enabled = try(var.vpc_endpoints[count.index]["private_dns_enabled"], null)
  route_table_ids     = try([var.vpc_endpoints[count.index]["route_table_ids"]], [])

  security_group_ids = (try(var.vpc_endpoints[count.index]["endpoint_type"], null) == "Interface") ? [try(aws_security_group.allow_443[0].id, null)] : []
  subnet_ids = (
    try(var.vpc_endpoints[count.index]["endpoint_subnet_scope"], "") == "private" ? local.private_subnets :
    try(var.vpc_endpoints[count.index]["endpoint_subnet_scope"], "") == "public" ? local.public_subnets :
    try(var.vpc_endpoints[count.index]["endpoint_subnet_scope"], "") == "internal" ? local.internal_subnets :
    []
  )

  vpc_endpoint_type = try(var.vpc_endpoints[count.index]["endpoint_type"], null)
  depends_on        = [aws_security_group.allow_443[0]]
  tags              = var.tags
}
