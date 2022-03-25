/*
VPC
*/

output "arn" {
  value       = aws_vpc.main.arn
  description = "Amazon Resource Name (ARN) of VPC"
}

output "id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "instance_tenancy" {
  value       = aws_vpc.main.instance_tenancy
  description = "Tenancy of instances spin up within VPC."
}

output "enable_dns_support" {
  value       = aws_vpc.main.enable_dns_support
  description = "Whether or not the VPC has DNS support"
}

output "enable_dns_hostnames" {
  value       = aws_vpc.main.enable_dns_hostnames
  description = "Whether or not the VPC has DNS hostname support"
}

output "enable_classiclink" {
  value       = aws_vpc.main.enable_classiclink
  description = "Whether or not the VPC has Classiclink enabled"
}

output "main_route_table_id" {
  value       = aws_vpc.main.main_route_table_id
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an `aws_main_route_table_association`."
}

output "default_network_acl_id" {
  value       = aws_vpc.main.default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation"
}

output "default_security_group_id" {
  value       = aws_vpc.main.default_security_group_id
  description = "The ID of the security group created by default on VPC creation"
}

output "default_route_table_id" {
  value       = aws_vpc.main.default_route_table_id
  description = "The ID of the route table created by default on VPC creation"
}

output "ipv6_association_id" {
  value       = aws_vpc.main.ipv6_association_id
  description = "The association ID for the IPv6 CIDR block."
}

output "ipv6_cidr_block_network_border_group" {
  value       = aws_vpc.main.ipv6_cidr_block_network_border_group
  description = "The Network Border Group Zone name"
}

output "owner_id" {
  value       = aws_vpc.main.owner_id
  description = "The ID of the AWS account that owns the VPC."
}

output "tags_all" {
  value       = aws_vpc.main.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

/*
VPC flow logs
*/

output "flow_logs_id" {
  value       = aws_flow_log.main.id
  description = "The Flow Log ID"
}

output "flow_logs_arn" {
  value       = aws_flow_log.main.arn
  description = "The ARN of the Flow Log."
}

output "flow_logs_tags_all" {
  value       = aws_flow_log.main.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [default_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

/*
subnets, route tables
*/

output "public_subnet_id" {
  value       = [aws_subnet.public.*.id]
  description = "The IDs of the public subnets"
}

output "private_subnet_id" {
  value       = [aws_subnet.private.*.id]
  description = "The IDs of the private subnets"
}

output "database_subnet_id" {
  value       = [aws_subnet.database.*.id]
  description = "The IDs of the database subnets"
}

output "public_eks_subnet_id" {
  value       = [aws_subnet.eks_public.*.id]
  description = "The IDs of the private subnets"
}

output "private_eks_subnet_id" {
  value       = [aws_subnet.eks_private.*.id]
  description = "The IDs of the private subnets"
}
