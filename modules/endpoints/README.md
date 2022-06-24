[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# vpc-endpoints

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.allow_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_endpoint.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.gatewayloadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_connection_notification.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_connection_notification) | resource |
| [aws_vpc_endpoint_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) | resource |
| [aws_vpc_endpoint_service_allowed_principal.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service_allowed_principal) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_events"></a> [connection\_events](#input\_connection\_events) | (Required) One or more endpoint [events](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpcEndpointConnectionNotification.html#API_CreateVpcEndpointConnectionNotification_RequestParameters) for which to receive notifications. | `list(string)` | <pre>[<br>  "Accept",<br>  "Reject"<br>]</pre> | no |
| <a name="input_connection_notification_arn"></a> [connection\_notification\_arn](#input\_connection\_notification\_arn) | (Required) The ARN of the SNS topic for the notifications. | `string` | `""` | no |
| <a name="input_create_gatewayloadbalancer_endpoint"></a> [create\_gatewayloadbalancer\_endpoint](#input\_create\_gatewayloadbalancer\_endpoint) | Choose whether to create gatewayloadbalancer endpoint | `bool` | `false` | no |
| <a name="input_create_vpc_endpoint_service"></a> [create\_vpc\_endpoint\_service](#input\_create\_vpc\_endpoint\_service) | Choose whether to create vpc endpoint service | `bool` | `false` | no |
| <a name="input_endpoint_service_acceptance_required"></a> [endpoint\_service\_acceptance\_required](#input\_endpoint\_service\_acceptance\_required) | (Required) Whether or not VPC endpoint connection requests to the service must be accepted by the service owner - `true` or `false`. | `bool` | `false` | no |
| <a name="input_endpoint_service_allowed_principal_arn"></a> [endpoint\_service\_allowed\_principal\_arn](#input\_endpoint\_service\_allowed\_principal\_arn) | (Required) The ARN of the principal to allow permissions. | `string` | `""` | no |
| <a name="input_endpoint_service_allowed_principals"></a> [endpoint\_service\_allowed\_principals](#input\_endpoint\_service\_allowed\_principals) | (Optional) The ARNs of one or more principals allowed to discover the endpoint service. | `list(string)` | `[]` | no |
| <a name="input_endpoint_service_gateway_load_balancer_arns"></a> [endpoint\_service\_gateway\_load\_balancer\_arns](#input\_endpoint\_service\_gateway\_load\_balancer\_arns) | (Optional) Amazon Resource Names (ARNs) of one or more Gateway Load Balancers for the endpoint service. | `set(string)` | `null` | no |
| <a name="input_endpoint_service_network_load_balancer_arns"></a> [endpoint\_service\_network\_load\_balancer\_arns](#input\_endpoint\_service\_network\_load\_balancer\_arns) | (Optional) Amazon Resource Names (ARNs) of one or more Network Load Balancers for the endpoint service. | `set(string)` | `null` | no |
| <a name="input_endpoint_service_private_dns_name"></a> [endpoint\_service\_private\_dns\_name](#input\_endpoint\_service\_private\_dns\_name) | (Optional) The private DNS name for the service. | `string` | `null` | no |
| <a name="input_gateway_endpoint_auto_accept"></a> [gateway\_endpoint\_auto\_accept](#input\_gateway\_endpoint\_auto\_accept) | (Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account). | `bool` | `false` | no |
| <a name="input_gateway_endpoint_policy"></a> [gateway\_endpoint\_policy](#input\_gateway\_endpoint\_policy) | (Optional) A policy to attach to the endpoint that controls access to the service. This is a JSON formatted string. Defaults to full access. All `Gateway` and some `Interface` endpoints support policies | `string` | `null` | no |
| <a name="input_gateway_endpoint_private_dns_enabled"></a> [gateway\_endpoint\_private\_dns\_enabled](#input\_gateway\_endpoint\_private\_dns\_enabled) | (Optional; AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type `Interface`. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_gateway_endpoint_route_table_ids"></a> [gateway\_endpoint\_route\_table\_ids](#input\_gateway\_endpoint\_route\_table\_ids) | (Optional) One or more route table IDs. Applicable for endpoints of type `Gateway`. | `list(string)` | `[]` | no |
| <a name="input_gateway_endpoint_security_group_ids"></a> [gateway\_endpoint\_security\_group\_ids](#input\_gateway\_endpoint\_security\_group\_ids) | (Optional) The ID of one or more security groups to associate with the network interface. Required for endpoints of type `Interface`. | `list(string)` | `[]` | no |
| <a name="input_gateway_endpoint_service_names"></a> [gateway\_endpoint\_service\_names](#input\_gateway\_endpoint\_service\_names) | (Required) The service name. For AWS services the service name is usually in the form `com.amazonaws.<region>.<service>` (the SageMaker Notebook service is an exception to this rule, the service name is in the form `aws.sagemaker.<region>.notebook`). | `list(string)` | `[]` | no |
| <a name="input_gateway_endpoint_subnet_ids"></a> [gateway\_endpoint\_subnet\_ids](#input\_gateway\_endpoint\_subnet\_ids) | (Optional) The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type `GatewayLoadBalancer` and `Interface`. | `list(string)` | `[]` | no |
| <a name="input_gateway_endpoint_tags"></a> [gateway\_endpoint\_tags](#input\_gateway\_endpoint\_tags) | A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_gateway_endpoint_timeouts"></a> [gateway\_endpoint\_timeouts](#input\_gateway\_endpoint\_timeouts) | Configuration block specifying how long to wait when creating, updating and deleting VPC endpoints. | `map(string)` | `{}` | no |
| <a name="input_gatewayloadbalancer_endpoint_auto_accept"></a> [gatewayloadbalancer\_endpoint\_auto\_accept](#input\_gatewayloadbalancer\_endpoint\_auto\_accept) | (Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account). | `bool` | `false` | no |
| <a name="input_gatewayloadbalancer_endpoint_policy"></a> [gatewayloadbalancer\_endpoint\_policy](#input\_gatewayloadbalancer\_endpoint\_policy) | (Optional) A policy to attach to the endpoint that controls access to the service. This is a JSON formatted string. Defaults to full access. All `Gateway` and some `Interface` endpoints support policies | `string` | `null` | no |
| <a name="input_gatewayloadbalancer_endpoint_private_dns_enabled"></a> [gatewayloadbalancer\_endpoint\_private\_dns\_enabled](#input\_gatewayloadbalancer\_endpoint\_private\_dns\_enabled) | (Optional; AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type `Interface`. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_gatewayloadbalancer_endpoint_route_table_ids"></a> [gatewayloadbalancer\_endpoint\_route\_table\_ids](#input\_gatewayloadbalancer\_endpoint\_route\_table\_ids) | (Optional) One or more route table IDs. Applicable for endpoints of type `Gateway`. | `list(string)` | `[]` | no |
| <a name="input_gatewayloadbalancer_endpoint_security_group_ids"></a> [gatewayloadbalancer\_endpoint\_security\_group\_ids](#input\_gatewayloadbalancer\_endpoint\_security\_group\_ids) | (Optional) The ID of one or more security groups to associate with the network interface. Required for endpoints of type `Interface`. | `list(string)` | `[]` | no |
| <a name="input_gatewayloadbalancer_endpoint_subnet_ids"></a> [gatewayloadbalancer\_endpoint\_subnet\_ids](#input\_gatewayloadbalancer\_endpoint\_subnet\_ids) | (Optional) The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type `GatewayLoadBalancer` and `Interface`. | `list(string)` | `[]` | no |
| <a name="input_gatewayloadbalancer_endpoint_tags"></a> [gatewayloadbalancer\_endpoint\_tags](#input\_gatewayloadbalancer\_endpoint\_tags) | A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_gatewayloadbalancer_endpoint_timeouts"></a> [gatewayloadbalancer\_endpoint\_timeouts](#input\_gatewayloadbalancer\_endpoint\_timeouts) | Configuration block specifying how long to wait when creating, updating and deleting VPC endpoints. | `map(string)` | `{}` | no |
| <a name="input_interface_endpoint_auto_accept"></a> [interface\_endpoint\_auto\_accept](#input\_interface\_endpoint\_auto\_accept) | (Optional) Accept the VPC endpoint (the VPC endpoint and service need to be in the same AWS account). | `bool` | `false` | no |
| <a name="input_interface_endpoint_policy"></a> [interface\_endpoint\_policy](#input\_interface\_endpoint\_policy) | (Optional) A policy to attach to the endpoint that controls access to the service. This is a JSON formatted string. Defaults to full access. All `Gateway` and some `Interface` endpoints support policies | `string` | `null` | no |
| <a name="input_interface_endpoint_private_dns_enabled"></a> [interface\_endpoint\_private\_dns\_enabled](#input\_interface\_endpoint\_private\_dns\_enabled) | (Optional; AWS services and AWS Marketplace partner services only) Whether or not to associate a private hosted zone with the specified VPC. Applicable for endpoints of type `Interface`. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_interface_endpoint_route_table_ids"></a> [interface\_endpoint\_route\_table\_ids](#input\_interface\_endpoint\_route\_table\_ids) | (Optional) One or more route table IDs. Applicable for endpoints of type `Gateway`. | `list(string)` | `[]` | no |
| <a name="input_interface_endpoint_service_names"></a> [interface\_endpoint\_service\_names](#input\_interface\_endpoint\_service\_names) | (Required) The service names. For AWS services the service name is usually in the form `com.amazonaws.<region>.<service>` (the SageMaker Notebook service is an exception to this rule, the service name is in the form `aws.sagemaker.<region>.notebook`). | `list(string)` | `[]` | no |
| <a name="input_interface_endpoint_subnet_ids"></a> [interface\_endpoint\_subnet\_ids](#input\_interface\_endpoint\_subnet\_ids) | (Optional) The ID of one or more subnets in which to create a network interface for the endpoint. Applicable for endpoints of type `GatewayLoadBalancer` and `Interface`. | `list(string)` | `[]` | no |
| <a name="input_interface_endpoint_tags"></a> [interface\_endpoint\_tags](#input\_interface\_endpoint\_tags) | A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_interface_endpoint_timeouts"></a> [interface\_endpoint\_timeouts](#input\_interface\_endpoint\_timeouts) | Configuration block specifying how long to wait when creating, updating and deleting VPC endpoints. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Required) The ID of the VPC in which the endpoint will be used. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_service_allowed_principal_id"></a> [endpoint\_service\_allowed\_principal\_id](#output\_endpoint\_service\_allowed\_principal\_id) | The ID of the association. |
| <a name="output_endpoint_service_arn"></a> [endpoint\_service\_arn](#output\_endpoint\_service\_arn) | The Amazon Resource Name (ARN) of the VPC endpoint service. |
| <a name="output_endpoint_service_availability_zones"></a> [endpoint\_service\_availability\_zones](#output\_endpoint\_service\_availability\_zones) | The Availability Zones in which the service is available. |
| <a name="output_endpoint_service_base_endpoint_dns_names"></a> [endpoint\_service\_base\_endpoint\_dns\_names](#output\_endpoint\_service\_base\_endpoint\_dns\_names) | The DNS names for the service. |
| <a name="output_endpoint_service_id"></a> [endpoint\_service\_id](#output\_endpoint\_service\_id) | The ID of the VPC endpoint service. |
| <a name="output_endpoint_service_manages_vpc_endpoints"></a> [endpoint\_service\_manages\_vpc\_endpoints](#output\_endpoint\_service\_manages\_vpc\_endpoints) | Whether or not the service manages its VPC endpoints - true or false. |
| <a name="output_endpoint_service_name"></a> [endpoint\_service\_name](#output\_endpoint\_service\_name) | The service name. |
| <a name="output_endpoint_service_private_dns_name_configuration"></a> [endpoint\_service\_private\_dns\_name\_configuration](#output\_endpoint\_service\_private\_dns\_name\_configuration) | List of objects containing information about the endpoint service private DNS name configuration. |
| <a name="output_endpoint_service_tags_all"></a> [endpoint\_service\_tags\_all](#output\_endpoint\_service\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_endpoint_service_type"></a> [endpoint\_service\_type](#output\_endpoint\_service\_type) | The service type, `Gateway` or `Interface`. |
| <a name="output_gateway_endpoint_arn"></a> [gateway\_endpoint\_arn](#output\_gateway\_endpoint\_arn) | The Amazon Resource Name (ARN) of the VPC endpoint. |
| <a name="output_gateway_endpoint_cidr_blocks"></a> [gateway\_endpoint\_cidr\_blocks](#output\_gateway\_endpoint\_cidr\_blocks) | The list of CIDR blocks for the exposed AWS service. Applicable for endpoints of type `Gateway`. |
| <a name="output_gateway_endpoint_dns_entry"></a> [gateway\_endpoint\_dns\_entry](#output\_gateway\_endpoint\_dns\_entry) | The DNS entries for the VPC Endpoint. Applicable for endpoints of type `Interface`. |
| <a name="output_gateway_endpoint_id"></a> [gateway\_endpoint\_id](#output\_gateway\_endpoint\_id) | The ID of the VPC endpoint. |
| <a name="output_gateway_endpoint_network_interface_ids"></a> [gateway\_endpoint\_network\_interface\_ids](#output\_gateway\_endpoint\_network\_interface\_ids) | One or more network interfaces for the VPC Endpoint. Applicable for endpoints of type `Interface`. |
| <a name="output_gateway_endpoint_owner_id"></a> [gateway\_endpoint\_owner\_id](#output\_gateway\_endpoint\_owner\_id) | The ID of the AWS account that owns the VPC endpoint. |
| <a name="output_gateway_endpoint_prefix_list_id"></a> [gateway\_endpoint\_prefix\_list\_id](#output\_gateway\_endpoint\_prefix\_list\_id) | The prefix list ID of the exposed AWS service. Applicable for endpoints of type `Gateway`. |
| <a name="output_gateway_endpoint_requester_managed"></a> [gateway\_endpoint\_requester\_managed](#output\_gateway\_endpoint\_requester\_managed) | Whether or not the VPC Endpoint is being managed by its service - `true` or `false`. |
| <a name="output_gateway_endpoint_state"></a> [gateway\_endpoint\_state](#output\_gateway\_endpoint\_state) | The state of the VPC endpoint. |
| <a name="output_gateway_endpoint_tags_all"></a> [gateway\_endpoint\_tags\_all](#output\_gateway\_endpoint\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_gatewayloadbalancer_endpoint_arn"></a> [gatewayloadbalancer\_endpoint\_arn](#output\_gatewayloadbalancer\_endpoint\_arn) | The Amazon Resource Name (ARN) of the VPC endpoint. |
| <a name="output_gatewayloadbalancer_endpoint_cidr_blocks"></a> [gatewayloadbalancer\_endpoint\_cidr\_blocks](#output\_gatewayloadbalancer\_endpoint\_cidr\_blocks) | The list of CIDR blocks for the exposed AWS service. Applicable for endpoints of type `Gateway`. |
| <a name="output_gatewayloadbalancer_endpoint_dns_entry"></a> [gatewayloadbalancer\_endpoint\_dns\_entry](#output\_gatewayloadbalancer\_endpoint\_dns\_entry) | The DNS entries for the VPC Endpoint. Applicable for endpoints of type `Interface`. |
| <a name="output_gatewayloadbalancer_endpoint_id"></a> [gatewayloadbalancer\_endpoint\_id](#output\_gatewayloadbalancer\_endpoint\_id) | The ID of the VPC endpoint. |
| <a name="output_gatewayloadbalancer_endpoint_network_interface_ids"></a> [gatewayloadbalancer\_endpoint\_network\_interface\_ids](#output\_gatewayloadbalancer\_endpoint\_network\_interface\_ids) | One or more network interfaces for the VPC Endpoint. Applicable for endpoints of type `Interface`. |
| <a name="output_gatewayloadbalancer_endpoint_owner_id"></a> [gatewayloadbalancer\_endpoint\_owner\_id](#output\_gatewayloadbalancer\_endpoint\_owner\_id) | The ID of the AWS account that owns the VPC endpoint. |
| <a name="output_gatewayloadbalancer_endpoint_prefix_list_id"></a> [gatewayloadbalancer\_endpoint\_prefix\_list\_id](#output\_gatewayloadbalancer\_endpoint\_prefix\_list\_id) | The prefix list ID of the exposed AWS service. Applicable for endpoints of type `Gateway`. |
| <a name="output_gatewayloadbalancer_endpoint_requester_managed"></a> [gatewayloadbalancer\_endpoint\_requester\_managed](#output\_gatewayloadbalancer\_endpoint\_requester\_managed) | Whether or not the VPC Endpoint is being managed by its service - `true` or `false`. |
| <a name="output_gatewayloadbalancer_endpoint_state"></a> [gatewayloadbalancer\_endpoint\_state](#output\_gatewayloadbalancer\_endpoint\_state) | The state of the VPC endpoint. |
| <a name="output_gatewayloadbalancer_endpoint_tags_all"></a> [gatewayloadbalancer\_endpoint\_tags\_all](#output\_gatewayloadbalancer\_endpoint\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_interface_endpoint_arn"></a> [interface\_endpoint\_arn](#output\_interface\_endpoint\_arn) | The Amazon Resource Name (ARN) of the VPC endpoint. |
| <a name="output_interface_endpoint_cidr_blocks"></a> [interface\_endpoint\_cidr\_blocks](#output\_interface\_endpoint\_cidr\_blocks) | The list of CIDR blocks for the exposed AWS service. Applicable for endpoints of type `Gateway`. |
| <a name="output_interface_endpoint_dns_entry"></a> [interface\_endpoint\_dns\_entry](#output\_interface\_endpoint\_dns\_entry) | The DNS entries for the VPC Endpoint. Applicable for endpoints of type `Interface`. |
| <a name="output_interface_endpoint_id"></a> [interface\_endpoint\_id](#output\_interface\_endpoint\_id) | The ID of the VPC endpoint. |
| <a name="output_interface_endpoint_network_interface_ids"></a> [interface\_endpoint\_network\_interface\_ids](#output\_interface\_endpoint\_network\_interface\_ids) | One or more network interfaces for the VPC Endpoint. Applicable for endpoints of type `Interface`. |
| <a name="output_interface_endpoint_owner_id"></a> [interface\_endpoint\_owner\_id](#output\_interface\_endpoint\_owner\_id) | The ID of the AWS account that owns the VPC endpoint. |
| <a name="output_interface_endpoint_prefix_list_id"></a> [interface\_endpoint\_prefix\_list\_id](#output\_interface\_endpoint\_prefix\_list\_id) | The prefix list ID of the exposed AWS service. Applicable for endpoints of type `Gateway`. |
| <a name="output_interface_endpoint_requester_managed"></a> [interface\_endpoint\_requester\_managed](#output\_interface\_endpoint\_requester\_managed) | Whether or not the VPC Endpoint is being managed by its service - `true` or `false`. |
| <a name="output_interface_endpoint_state"></a> [interface\_endpoint\_state](#output\_interface\_endpoint\_state) | The state of the VPC endpoint. |
| <a name="output_interface_endpoint_tags_all"></a> [interface\_endpoint\_tags\_all](#output\_interface\_endpoint\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_vpc_endpoint_connection_notification_id"></a> [vpc\_endpoint\_connection\_notification\_id](#output\_vpc\_endpoint\_connection\_notification\_id) | The ID of the VPC connection notification. |
| <a name="output_vpc_endpoint_connection_notification_notification_type"></a> [vpc\_endpoint\_connection\_notification\_notification\_type](#output\_vpc\_endpoint\_connection\_notification\_notification\_type) | The type of notification. |
| <a name="output_vpc_endpoint_connection_notification_state"></a> [vpc\_endpoint\_connection\_notification\_state](#output\_vpc\_endpoint\_connection\_notification\_state) | The state of the notification. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compability we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

#### BOLDLink-SIG 2022
