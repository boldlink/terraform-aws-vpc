locals {
  dns_suffix = data.aws_partition.current.dns_suffix
  partition  = data.aws_partition.current.partition
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.id
  # logs_bucket_name  = var.logs_bucket_name == null ? "${var.name}-vpc-logs-${local.region}-${local.account_id}" : var.logs_bucket_name
  log_group_name    = var.log_group_name == null ? "/aws/vpc/${var.name}" : var.log_group_name
  vpc_assume_policy = var.vpc_assume_policy == null ? data.aws_iam_policy_document.assume_policy.json : var.vpc_assume_policy
  vpc_role_policy   = var.vpc_role_policy == null ? data.aws_iam_policy_document.role_policy.json : var.vpc_role_policy
  # vpc_s3_role_policy   = var.vpc_s3_role_policy == null ? data.aws_iam_policy_document.s3_role_policy.json : var.vpc_s3_role_policy
  # vpc_s3_bucket_policy = var.vpc_s3_bucket_policy == null ? data.aws_iam_policy_document.s3_bucket_policy.json : var.vpc_s3_bucket_policy
  log_format = var.log_destination_type == "s3" ? var.log_format : null
  nat_gateways = [
    data.aws_nat_gateways.a.*.ids,
    data.aws_nat_gateways.b.*.ids,
    data.aws_nat_gateways.c.*.ids
  ]
}
