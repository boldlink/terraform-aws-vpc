output "arn" {
  value       = aws_vpc_ipam.main.arn
  description = "Amazon Resource Name (ARN) of IPAM"
}

output "id" {
  value       = aws_vpc_ipam.main.id
  description = "The ID of the IPAM"
}

output "private_default_scope_id" {
  value       = aws_vpc_ipam.main.private_default_scope_id
  description = "The ID of the IPAM's private scope. A scope is a top-level container in IPAM. Each scope represents an IP-independent network. Scopes enable you to represent networks where you have overlapping IP space. When you create an IPAM, IPAM automatically creates two scopes: public and private. The private scope is intended for private IP space. The public scope is intended for all internet-routable IP space."
}

output "public_default_scope_id" {
  value       = aws_vpc_ipam.main.public_default_scope_id
  description = "The ID of the IPAM's public scope. A scope is a top-level container in IPAM. Each scope represents an IP-independent network. Scopes enable you to represent networks where you have overlapping IP space. When you create an IPAM, IPAM automatically creates two scopes: public and private. The private scope is intended for private IP space. The public scope is intended for all internet-routable IP space."
}

output "scope_count" {
  value       = aws_vpc_ipam.main.scope_count
  description = "The number of scopes in the IPAM."
}

output "tags_all" {
  value       = aws_vpc_ipam.main.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

##########################################
## AWS vpc ipam organization admin account
##########################################

output "ipam_organization_admin_account_arn" {
  value       = join("", aws_vpc_ipam_organization_admin_account.main.*.arn)
  description = "The Organizations ARN for the delegate account."
}

output "ipam_organization_admin_account_id" {
  value       = join("", aws_vpc_ipam_organization_admin_account.main.*.id)
  description = "The Organizations member account ID that you want to enable as the IPAM account."
}

output "ipam_organization_admin_account_email" {
  value       = join("", aws_vpc_ipam_organization_admin_account.main.*.email)
  description = "The Organizations email for the delegate account."
}

output "ipam_organization_admin_account_name" {
  value       = join("", aws_vpc_ipam_organization_admin_account.main.*.name)
  description = "The Organizations name for the delegate account."
}

output "ipam_organization_admin_account_service_principal" {
  value       = join("", aws_vpc_ipam_organization_admin_account.main.*.service_principal)
  description = "The AWS service principal."
}

##########################################
## aws vpc ipam pool
##########################################

output "ipam_pool_arn" {
  value       = aws_vpc_ipam_pool.main.arn
  description = "Amazon Resource Name (ARN) of IPAM"
}

output "ipam_pool_id" {
  value       = aws_vpc_ipam_pool.main.id
  description = "The ID of the IPAM"
}

output "ipam_pool_state" {
  value       = aws_vpc_ipam_pool.main.state
  description = "The ID of the IPAM"
}

output "ipam_pool_tags_all" {
  value       = aws_vpc_ipam_pool.main.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

##########################################
## aws vpc ipam pool cidr
##########################################

output "ipam_pool_cidr_id" {
  value       = aws_vpc_ipam_pool_cidr.main.*.id
  description = "The ID of the IPAM Pool Cidr concatenated with the IPAM Pool ID."
}

##########################################
## aws vpc ipam pool cidr allocation
##########################################

output "pool_allocation_id" {
  value       = aws_vpc_ipam_pool_cidr_allocation.main.*.id
  description = "The ID of the allocation."
}

output "pool_allocation_resource_id" {
  value       = aws_vpc_ipam_pool_cidr_allocation.main.*.resource_id
  description = "The ID of the resource."
}

output "pool_allocation_resource_owner" {
  value       = aws_vpc_ipam_pool_cidr_allocation.main.*.resource_owner
  description = "The owner of the resource."
}

output "pool_allocation_resource_type" {
  value       = aws_vpc_ipam_pool_cidr_allocation.main.*.resource_type
  description = "The type of the resource."
}

##########################################
## aws vpc ipam preview next cidr
##########################################

output "ipam_preview_cidr" {
  value       = aws_vpc_ipam_preview_next_cidr.main.*.cidr
  description = "The previewed CIDR from the pool."
}

output "ipam_preview_id" {
  value       = aws_vpc_ipam_preview_next_cidr.main.*.id
  description = "The ID of the preview."
}

##########################################
## aws vpc ipam scope
##########################################

output "ipam_scope_id" {
  value       = aws_vpc_ipam_scope.main.id
  description = "The ID of the IPAM Scope."
}

output "ipam_scope_ipam_arn" {
  value       = aws_vpc_ipam_scope.main.ipam_arn
  description = "The ARN of the IPAM for which you're creating this scope."
}

output "ipam_scope_is_default" {
  value       = aws_vpc_ipam_scope.main.is_default
  description = "Defines if the scope is the default scope or not."
}

output "ipam_scope_pool_count" {
  value       = aws_vpc_ipam_scope.main.pool_count
  description = "Count of pools under this scope"
}
