resource "aws_vpc_ipam" "main" {
  description = var.ipam_description
  operating_regions {
    region_name = lookup(var.operating_regions, "region_name", null)
  }
  tags = var.tags
}

resource "aws_vpc_ipam_organization_admin_account" "main" {
  count                      = var.enable_ipam_organization_admin_account ? 1 : 0
  delegated_admin_account_id = var.delegated_admin_account_id
}

###########################
### aws vpc ipam pool
###########################

resource "aws_vpc_ipam_pool" "main" {
  address_family                    = var.address_family
  locale                            = var.locale
  publicly_advertisable             = var.publicly_advertisable
  allocation_default_netmask_length = var.allocation_default_netmask_length
  allocation_max_netmask_length     = var.allocation_max_netmask_length
  allocation_min_netmask_length     = var.allocation_min_netmask_length
  allocation_resource_tags          = var.allocation_resource_tags
  auto_import                       = var.auto_import
  aws_service                       = var.aws_service
  description                       = var.ipam_pool_description
  ipam_scope_id                     = aws_vpc_ipam.main.private_default_scope_id
  source_ipam_pool_id               = var.source_ipam_pool_id
  tags                              = var.tags
}

resource "aws_vpc_ipam_pool_cidr" "main" {
  ipam_pool_id = aws_vpc_ipam_pool.main.id
  count        = var.ipam_pool_cidr != null ? 1 : 0
  cidr         = var.ipam_pool_cidr
  dynamic "cidr_authorization_context" {
    for_each = var.cidr_authorization_context
    content {
      message   = lookup(cidr_authorization_context.value, "message", null)
      signature = lookup(cidr_authorization_context.value, "signature", null)
    }
  }
}

##########################################
## aws vpc ipam pool cidr allocation
##########################################

resource "aws_vpc_ipam_pool_cidr_allocation" "main" {
  count        = var.pool_allocation_cidr != null ? 1 : 0
  ipam_pool_id = aws_vpc_ipam_pool.main.id
  cidr         = var.pool_allocation_cidr
  depends_on = [
    aws_vpc_ipam_pool_cidr.main
  ]
}

##########################################
## aws vpc ipam preview next cidr
##########################################

resource "aws_vpc_ipam_preview_next_cidr" "main" {
  count            = var.ipam_preview_netmask_length > 0 ? 1 : 0
  ipam_pool_id     = aws_vpc_ipam_pool.main.id
  netmask_length   = var.ipam_preview_netmask_length
  disallowed_cidrs = var.ipam_preview_disallowed_cidrs
  depends_on = [
    aws_vpc_ipam_pool_cidr.main
  ]
}

##########################################
## aws vpc ipam scope
##########################################

resource "aws_vpc_ipam_scope" "main" {
  ipam_id     = aws_vpc_ipam.main.id
  description = var.ipam_scope_description
}
