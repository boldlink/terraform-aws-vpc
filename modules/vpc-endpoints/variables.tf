variable "vpc_id" {
  type        = string
  description = "(Required) The ID of the VPC in which the endpoint will be used."
}

#############################################
##Interface endpoint
#############################################

variable "interface_endpoint_service_names" {
  type        = list(string)
  description = "(Required) The service names. For AWS services the service name is usually in the form `com.amazonaws.<region>.<service>` (the SageMaker Notebook service is an exception to this rule, the service name is in the form `aws.sagemaker.<region>.notebook`)."
  default     = []
}

variable "interface_endpoint_auto_accept" {
  type        = bool
  description = "(Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account)."
  default     = false
}

variable "interface_endpoint_policy" {
  type        = string
  description = "(Optional) A policy to attach to the endpoint that controls access to the service. This is a JSON formatted string. Defaults to full access. All `Gateway` and some `Interface` endpoints support policies "
  default     = null
}

variable "interface_endpoint_private_dns_enabled" {
  type        = bool
  description = "(Optional; AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type `Interface`. Defaults to `false`."
  default     = false
}

variable "interface_endpoint_route_table_ids" {
  type        = list(string)
  description = "(Optional) One or more route table IDs. Applicable for endpoints of type `Gateway`."
  default     = []
}

variable "interface_endpoint_subnet_ids" {
  type        = list(string)
  description = "(Optional) The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type `GatewayLoadBalancer` and `Interface`."
  default     = []
}

variable "interface_endpoint_security_group_ids" {
  type        = list(string)
  description = "(Optional) The ID of one or more security groups to associate with the network interface. Required for endpoints of type `Interface`."
  default     = []
}

variable "interface_endpoint_tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "interface_endpoint_timeouts" {
  type        = map(string)
  description = "Configuration block specifying how long to wait when creating, updating and deleting VPC endpoints."
  default     = {}
}

#############################################
##Gateway Interface
#############################################

variable "gateway_endpoint_service_names" {
  type        = list(string)
  description = "(Required) The service name. For AWS services the service name is usually in the form `com.amazonaws.<region>.<service>` (the SageMaker Notebook service is an exception to this rule, the service name is in the form `aws.sagemaker.<region>.notebook`)."
  default     = []
}

variable "gateway_endpoint_auto_accept" {
  type        = bool
  description = "(Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account)."
  default     = false
}

variable "gateway_endpoint_policy" {
  type        = string
  description = "(Optional) A policy to attach to the endpoint that controls access to the service. This is a JSON formatted string. Defaults to full access. All `Gateway` and some `Interface` endpoints support policies "
  default     = null
}

variable "gateway_endpoint_private_dns_enabled" {
  type        = bool
  description = "(Optional; AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type `Interface`. Defaults to `false`."
  default     = false
}

variable "gateway_endpoint_route_table_ids" {
  type        = list(string)
  description = "(Optional) One or more route table IDs. Applicable for endpoints of type `Gateway`."
  default     = []
}

variable "gateway_endpoint_subnet_ids" {
  type        = list(string)
  description = "(Optional) The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type `GatewayLoadBalancer` and `Interface`."
  default     = []
}

variable "gateway_endpoint_security_group_ids" {
  type        = list(string)
  description = "(Optional) The ID of one or more security groups to associate with the network interface. Required for endpoints of type `Interface`."
  default     = []
}

variable "gateway_endpoint_tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "gateway_endpoint_timeouts" {
  type        = map(string)
  description = "Configuration block specifying how long to wait when creating, updating and deleting VPC endpoints."
  default     = {}
}

#############################################
##
#############################################

variable "gatewayloadbalancer_endpoint_auto_accept" {
  type        = bool
  description = "(Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account)."
  default     = false
}

variable "gatewayloadbalancer_endpoint_policy" {
  type        = string
  description = "(Optional) A policy to attach to the endpoint that controls access to the service. This is a JSON formatted string. Defaults to full access. All `Gateway` and some `Interface` endpoints support policies "
  default     = null
}

variable "gatewayloadbalancer_endpoint_private_dns_enabled" {
  type        = bool
  description = "(Optional; AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type `Interface`. Defaults to `false`."
  default     = false
}

variable "gatewayloadbalancer_endpoint_route_table_ids" {
  type        = list(string)
  description = "(Optional) One or more route table IDs. Applicable for endpoints of type `Gateway`."
  default     = []
}

variable "gatewayloadbalancer_endpoint_subnet_ids" {
  type        = list(string)
  description = "(Optional) The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type `GatewayLoadBalancer` and `Interface`."
  default     = []
}

variable "gatewayloadbalancer_endpoint_security_group_ids" {
  type        = list(string)
  description = "(Optional) The ID of one or more security groups to associate with the network interface. Required for endpoints of type `Interface`."
  default     = []
}

variable "gatewayloadbalancer_endpoint_tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "gatewayloadbalancer_endpoint_timeouts" {
  type        = map(string)
  description = "Configuration block specifying how long to wait when creating, updating and deleting VPC endpoints."
  default     = {}
}

/*
aws_vpc_endpoint_connection_notification
*/

variable "connection_notification_arn" {
  type        = string
  description = "(Required) The ARN of the SNS topic for the notifications."
  default     = ""
}

variable "connection_events" {
  type        = list(string)
  description = "(Required) One or more endpoint [events](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpcEndpointConnectionNotification.html#API_CreateVpcEndpointConnectionNotification_RequestParameters) for which to receive notifications."
  default     = ["Accept", "Reject"]
}

/*
aws_vpc_endpoint_service
*/

variable "endpoint_service_acceptance_required" {
  type        = bool
  description = "(Required) Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - `true` or `false`."
  default     = false
}

variable "endpoint_service_allowed_principals" {
  type        = list(string)
  description = "(Optional) The ARNs of one or more principals allowed to discover the endpoint service."
  default     = []
}

variable "endpoint_service_gateway_load_balancer_arns" {
  type        = set(string)
  description = "(Optional) Amazon Resource Names (ARNs) of one or more Gateway Load Balancers for the endpoint service."
  default     = null
}

variable "endpoint_service_network_load_balancer_arns" {
  type        = set(string)
  description = "(Optional) Amazon Resource Names (ARNs) of one or more Network Load Balancers for the endpoint service."
  default     = null
}

variable "endpoint_service_private_dns_name" {
  type        = string
  description = "(Optional) The private DNS name for the service."
  default     = null
}

/*
aws_vpc_endpoint_service_allowed_principal
*/

variable "endpoint_service_allowed_principal_arn" {
  type        = string
  description = "(Required) The ARN of the principal to allow permissions."
  default     = ""
}

variable "create_vpc_endpoint_service" {
  type        = bool
  description = "Choose whether to create vpc endpoint service"
  default     = false
}

variable "create_gatewayloadbalancer_endpoint" {
  type        = bool
  description = "Choose whether to create gatewayloadbalancer endpoint"
  default     = false
}
