#### Interface endpoint Type

output "interface_endpoint_id" {
  value       = aws_vpc_endpoint.interface.*.id
  description = "The ID of the VPC endpoint."
}

output "interface_endpoint_arn" {
  value       = aws_vpc_endpoint.interface.*.arn
  description = "The Amazon Resource Name (ARN) of the VPC endpoint."
}

output "interface_endpoint_cidr_blocks" {
  value       = aws_vpc_endpoint.interface.*.cidr_blocks
  description = "The list of CIDR blocks for the exposed AWS service. Applicable for endpoints of type `Gateway`."
}

output "interface_endpoint_dns_entry" {
  value       = aws_vpc_endpoint.interface.*.dns_entry
  description = "The DNS entries for the VPC Endpoint. Applicable for endpoints of type `Interface`."
}

output "interface_endpoint_network_interface_ids" {
  value       = aws_vpc_endpoint.interface.*.network_interface_ids
  description = "One or more network interfaces for the VPC Endpoint. Applicable for endpoints of type `Interface`."
}

output "interface_endpoint_owner_id" {
  value       = aws_vpc_endpoint.interface.*.owner_id
  description = " The ID of the AWS account that owns the VPC endpoint."
}

output "interface_endpoint_prefix_list_id" {
  value       = aws_vpc_endpoint.interface.*.prefix_list_id
  description = "The prefix list ID of the exposed AWS service. Applicable for endpoints of type `Gateway`."
}

output "interface_endpoint_requester_managed" {
  value       = aws_vpc_endpoint.interface.*.requester_managed
  description = "Whether or not the VPC Endpoint is being managed by its service - `true` or `false`."
}

output "interface_endpoint_state" {
  value       = aws_vpc_endpoint.interface.*.state
  description = "The state of the VPC endpoint."
}

output "interface_endpoint_tags_all" {
  value       = aws_vpc_endpoint.interface.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

##### Gateway Endpoint Type

output "gateway_endpoint_id" {
  value       = aws_vpc_endpoint.gateway.*.id
  description = "The ID of the VPC endpoint."
}

output "gateway_endpoint_arn" {
  value       = aws_vpc_endpoint.gateway.*.arn
  description = "The Amazon Resource Name (ARN) of the VPC endpoint."
}

output "gateway_endpoint_cidr_blocks" {
  value       = aws_vpc_endpoint.gateway.*.cidr_blocks
  description = "The list of CIDR blocks for the exposed AWS service. Applicable for endpoints of type `Gateway`."
}

output "gateway_endpoint_dns_entry" {
  value       = aws_vpc_endpoint.gateway.*.dns_entry
  description = "The DNS entries for the VPC Endpoint. Applicable for endpoints of type `Interface`."
}

output "gateway_endpoint_network_interface_ids" {
  value       = aws_vpc_endpoint.gateway.*.network_interface_ids
  description = "One or more network interfaces for the VPC Endpoint. Applicable for endpoints of type `Interface`."
}

output "gateway_endpoint_owner_id" {
  value       = aws_vpc_endpoint.gateway.*.owner_id
  description = " The ID of the AWS account that owns the VPC endpoint."
}

output "gateway_endpoint_prefix_list_id" {
  value       = aws_vpc_endpoint.gateway.*.prefix_list_id
  description = "The prefix list ID of the exposed AWS service. Applicable for endpoints of type `Gateway`."
}

output "gateway_endpoint_requester_managed" {
  value       = aws_vpc_endpoint.gateway.*.requester_managed
  description = "Whether or not the VPC Endpoint is being managed by its service - `true` or `false`."
}

output "gateway_endpoint_state" {
  value       = aws_vpc_endpoint.gateway.*.state
  description = "The state of the VPC endpoint."
}

output "gateway_endpoint_tags_all" {
  value       = aws_vpc_endpoint.gateway.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

########## GatwayLoadbalancer Endpoint type

output "gatewayloadbalancer_endpoint_id" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.id
  description = "The ID of the VPC endpoint."
}

output "gatewayloadbalancer_endpoint_arn" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.arn
  description = "The Amazon Resource Name (ARN) of the VPC endpoint."
}

output "gatewayloadbalancer_endpoint_cidr_blocks" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.cidr_blocks
  description = "The list of CIDR blocks for the exposed AWS service. Applicable for endpoints of type `Gateway`."
}

output "gatewayloadbalancer_endpoint_dns_entry" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.dns_entry
  description = "The DNS entries for the VPC Endpoint. Applicable for endpoints of type `Interface`."
}

output "gatewayloadbalancer_endpoint_network_interface_ids" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.network_interface_ids
  description = "One or more network interfaces for the VPC Endpoint. Applicable for endpoints of type `Interface`."
}

output "gatewayloadbalancer_endpoint_owner_id" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.owner_id
  description = " The ID of the AWS account that owns the VPC endpoint."
}

output "gatewayloadbalancer_endpoint_prefix_list_id" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.prefix_list_id
  description = "The prefix list ID of the exposed AWS service. Applicable for endpoints of type `Gateway`."
}

output "gatewayloadbalancer_endpoint_requester_managed" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.requester_managed
  description = "Whether or not the VPC Endpoint is being managed by its service - `true` or `false`."
}

output "gatewayloadbalancer_endpoint_state" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.state
  description = "The state of the VPC endpoint."
}

output "gatewayloadbalancer_endpoint_tags_all" {
  value       = aws_vpc_endpoint.gatewayloadbalancer.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

/*
aws_vpc_endpoint_connection_notification
*/

output "vpc_endpoint_connection_notification_id" {
  value       = aws_vpc_endpoint_connection_notification.main.*.id
  description = "The ID of the VPC connection notification."
}

output "vpc_endpoint_connection_notification_state" {
  value       = aws_vpc_endpoint_connection_notification.main.*.state
  description = "The state of the notification."
}

output "vpc_endpoint_connection_notification_notification_type" {
  value       = aws_vpc_endpoint_connection_notification.main.*.notification_type
  description = "The type of notification."
}

/*
aws_vpc_endpoint_service
*/

output "endpoint_service_id" {
  value       = aws_vpc_endpoint_service.main.*.id
  description = "The ID of the VPC endpoint service."
}

output "endpoint_service_availability_zones" {
  value       = aws_vpc_endpoint_service.main.*.availability_zones
  description = "The Availability Zones in which the service is available."
}

output "endpoint_service_arn" {
  value       = aws_vpc_endpoint_service.main.*.arn
  description = "The Amazon Resource Name (ARN) of the VPC endpoint service."
}

output "endpoint_service_base_endpoint_dns_names" {
  value       = aws_vpc_endpoint_service.main.*.base_endpoint_dns_names
  description = "The DNS names for the service."
}

output "endpoint_service_manages_vpc_endpoints" {
  value       = aws_vpc_endpoint_service.main.*.manages_vpc_endpoints
  description = "Whether or not the service manages its VPC endpoints - true or false."
}

output "endpoint_service_name" {
  value       = aws_vpc_endpoint_service.main.*.service_name
  description = "The service name."
}

output "endpoint_service_type" {
  value       = aws_vpc_endpoint_service.main.*.service_type
  description = "The service type, `Gateway` or `Interface`."
}

output "endpoint_service_private_dns_name_configuration" {
  value       = aws_vpc_endpoint_service.main.*.private_dns_name_configuration
  description = "List of objects containing information about the endpoint service private DNS name configuration."
}

output "endpoint_service_tags_all" {
  value       = aws_vpc_endpoint_service.main.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block)."
}

/*
aws_vpc_endpoint_service_allowed_principal
*/

output "endpoint_service_allowed_principal_id" {
  value       = aws_vpc_endpoint_service_allowed_principal.main.*.id
  description = "The ID of the association."
}
