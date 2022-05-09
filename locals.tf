locals {
  log_group_name = "/aws/vpc/${var.name}"
  dns_suffix     = data.aws_partition.current.dns_suffix
}
