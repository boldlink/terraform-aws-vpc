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
      "Name" = var.name
    },
    var.tags,
  )
}

/*
VPC flow logs
*/
resource "aws_flow_log" "main" {
  vpc_id       = aws_vpc.main.id
  traffic_type = var.traffic_type
  eni_id       = var.flow_log_eni_id
  iam_role_arn = aws_iam_role.main.arn
  # iam_role_arn             = var.log_destination_type == "cloud-watch-logs" ? aws_iam_role.main.arn : null
  log_destination_type = var.log_destination_type
  # log_destination          = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.main[0].arn : aws_s3_bucket.main[0].arn
  log_destination          = aws_cloudwatch_log_group.main[0].arn
  subnet_id                = var.flow_log_subnet_id
  log_format               = local.log_format
  max_aggregation_interval = var.max_aggregation_interval
  dynamic "destination_options" {
    for_each = var.destination_options
    content {
      file_format                = lookup(destination_options.value, "file_format", null)
      hive_compatible_partitions = lookup(destination_options.value, "hive_compatible_partitions", null)
      per_hour_partition         = lookup(destination_options.value, "per_hour_partition", null)
    }
  }
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
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

/*
VPC Logs S3 configuration
*/
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

/*
VPC Logs IAM Role
*/
resource "aws_iam_role" "main" {
  name               = "${var.name}-vpc-logs-role"
  assume_role_policy = local.vpc_assume_policy
  tags = merge(
    {
      "Name" = "${var.name}-vpc-logs-role"
    },
    var.tags,
  )
}

resource "aws_iam_role_policy" "main" {
  name   = "${var.name}-vpc-logs-policy"
  role   = aws_iam_role.main.id
  policy = local.vpc_role_policy
}

# resource "aws_iam_role_policy" "s3" {
#   count  = var.log_destination_type == "s3" ? 1 : 0
#   role   = aws_iam_role.main.id
#   policy = local.vpc_s3_role_policy
# }

/*
DHCP options Set
*/
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


/*
VPC DHCP Options Set Association
*/
resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}
