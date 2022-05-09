# AWS VPC Terraform module

## Description

This terraform module creates a VPC, public subnets, private subnets with access to the internet using a NAT gateway. It also provides an option of creating isolated subnets, which means they don't have access to the internet. The module can also be used to create EKS and database subnets and the corresponding database subnet groups.

Examples available [`here`](https://github.com/boldlink/terraform-aws-vpc/tree/main/examples)

## Usage
*NOTE*: These examples use the latest version of this module

```hcl
##############
## Single NAT
##############

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

locals {
  name           = "boldlink-test"
  cidr_block     = "10.0.0.0/16"
  tag_env        = "dev"
  public_subnet1 = cidrsubnet(local.cidr_block, 8, 50)
  public_subnet2 = cidrsubnet(local.cidr_block, 8, 55)
  public_subnet3 = cidrsubnet(local.cidr_block, 8, 60)
  public_subnets = [local.public_subnet1, local.public_subnet2, local.public_subnet3]

  private_subnet1 = cidrsubnet(local.cidr_block, 8, 20)
  private_subnet2 = cidrsubnet(local.cidr_block, 8, 25)
  private_subnet3 = cidrsubnet(local.cidr_block, 8, 30)
  private_subnets = [local.private_subnet1, local.private_subnet2, local.private_subnet3]

  az1 = data.aws_availability_zones.available.names[0]
  az2 = data.aws_availability_zones.available.names[1]
  az3 = data.aws_availability_zones.available.names[2]
  azs = [local.az1, local.az2, local.az3]
}

module "single_nat_vpc" {
  source                  = "boldlink/vpc/aws"
  name                    = local.name
  account                 = data.aws_caller_identity.current.account_id
  region                  = data.aws_region.current.name
  tag_env                 = local.tag_env
  cidr_block              = local.cidr_block
  enable_dns_support      = true
  enable_dns_hostnames    = true
  public_subnets          = local.public_subnets
  private_subnets         = local.private_subnets
  availability_zones      = local.azs
  map_public_ip_on_launch = true
  create_nat_gateway      = true
  nat_single_az           = true
}

output "outputs" {
  value = [
    module.single_nat_vpc,
  ]
}
```
## Documentation

[Amazon VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eip.multi_az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.single_az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.multi_az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.single_az](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_multi_az_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.private_single_az_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.eks_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.eks_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_subnet.eks_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.eks_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
<<<<<<< HEAD
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
=======
>>>>>>> main

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | (Required) Account ID to use to create resources | `string` | n/a | yes |
| <a name="input_assign_generated_ipv6_cidr_block"></a> [assign\_generated\_ipv6\_cidr\_block](#input\_assign\_generated\_ipv6\_cidr\_block) | (Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false. Conflicts with `ipv6_ipam_pool_id` | `bool` | `false` | no |
| <a name="input_assign_ipv6_address_on_creation"></a> [assign\_ipv6\_address\_on\_creation](#input\_assign\_ipv6\_address\_on\_creation) | (Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is `false`. | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of AZs of the subnets | `list(string)` | `[]` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length`. | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Input name of EKS Cluster. Provide this when creating EKS subnets | `string` | `"none"` | no |
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | Specify whether you want to create NAT Gateway(s) or not | `bool` | `false` | no |
| <a name="input_destination_options"></a> [destination\_options](#input\_destination\_options) | (Optional) Describes the destination options for a flow log. | `map(string)` | `{}` | no |
| <a name="input_dhcp_domain_name"></a> [dhcp\_domain\_name](#input\_dhcp\_domain\_name) | (Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the `search` value in the `/etc/resolv.conf` file. | `string` | `null` | no |
| <a name="input_domain_name_servers"></a> [domain\_name\_servers](#input\_domain\_name\_servers) | (Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to `AmazonProvidedDNS`. | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| <a name="input_eks_private_subnets"></a> [eks\_private\_subnets](#input\_eks\_private\_subnets) | The CIDR blocks of the Private EKS subnets | `list(string)` | `[]` | no |
| <a name="input_eks_public_subnets"></a> [eks\_public\_subnets](#input\_eks\_public\_subnets) | The CIDR blocks of the Public EKS subnets | `list(string)` | `[]` | no |
| <a name="input_enable_classiclink"></a> [enable\_classiclink](#input\_enable\_classiclink) | (Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the [ClassicLink documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html) for more information. Defaults false. | `bool` | `false` | no |
| <a name="input_enable_classiclink_dns_support"></a> [enable\_classiclink\_dns\_support](#input\_enable\_classiclink\_dns\_support) | (Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic. | `bool` | `false` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults `false`. | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults `true`. | `bool` | `true` | no |
| <a name="input_flow_log_eni_id"></a> [flow\_log\_eni\_id](#input\_flow\_log\_eni\_id) | (Optional) Elastic Network Interface ID to attach to | `string` | `null` | no |
| <a name="input_flow_log_subnet_id"></a> [flow\_log\_subnet\_id](#input\_flow\_log\_subnet\_id) | (Optional) Subnet ID to attach to | `string` | `null` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | (Optional) A tenancy option for instances launched into the VPC. Default is `default`, which makes your instances shared on the host. Using either of the other options (`dedicated` or `host`) costs at least `$2/hr`. | `string` | `"default"` | no |
| <a name="input_internal_subnets"></a> [internal\_subnets](#input\_internal\_subnets) | The CIDR blocks of the Private internal subnets, that is, subnets without internet access. | `list(string)` | `[]` | no |
| <a name="input_ipv4_ipam_pool_id"></a> [ipv4\_ipam\_pool\_id](#input\_ipv4\_ipam\_pool\_id) | (Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR. IPAM is a VPC feature that you can use to automate your IP address management workflows including assigning, tracking, troubleshooting, and auditing IP addresses across AWS Regions and accounts. Using IPAM you can monitor IP address usage throughout your AWS Organization. | `string` | `null` | no |
| <a name="input_ipv4_netmask_length"></a> [ipv4\_netmask\_length](#input\_ipv4\_netmask\_length) | (Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a `ipv4_ipam_pool_id`. | `number` | `null` | no |
| <a name="input_ipv6_cidr_block"></a> [ipv6\_cidr\_block](#input\_ipv6\_cidr\_block) | (Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using `ipv6_netmask_length`. | `string` | `null` | no |
| <a name="input_ipv6_cidr_block_network_border_group"></a> [ipv6\_cidr\_block\_network\_border\_group](#input\_ipv6\_cidr\_block\_network\_border\_group) | (Optional) By default when an IPv6 CIDR is assigned to a VPC a default ipv6\_cidr\_block\_network\_border\_group will be set to the region of the VPC. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones. | `string` | `null` | no |
| <a name="input_ipv6_ipam_pool_id"></a> [ipv6\_ipam\_pool\_id](#input\_ipv6\_ipam\_pool\_id) | (Optional) IPAM Pool ID for a IPv6 pool. Conflicts with `assign_generated_ipv6_cidr_block`. | `string` | `null` | no |
| <a name="input_ipv6_netmask_length"></a> [ipv6\_netmask\_length](#input\_ipv6\_netmask\_length) | (Optional) Netmask length to request from IPAM Pool. Conflicts with ipv6\_cidr\_block. This can be omitted if IPAM pool as a allocation\_default\_netmask\_length set. Valid values: `56`. | `number` | `null` | no |
| <a name="input_log_destination_type"></a> [log\_destination\_type](#input\_log\_destination\_type) | (Optional) The type of the logging destination. Valid values: `cloud-watch-logs`, `s3`. Default: `cloud-watch-logs`. | `string` | `"cloud-watch-logs"` | no |
| <a name="input_log_format"></a> [log\_format](#input\_log\_format) | (Optional) The fields to include in the flow log record, in the order in which they should appear. | `string` | `null` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is `false`. | `bool` | `false` | no |
| <a name="input_max_aggregation_interval"></a> [max\_aggregation\_interval](#input\_max\_aggregation\_interval) | (Optional) The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60 seconds (1 minute) or 600 seconds (10 minutes)`. Default: `600`. | `number` | `600` | no |
| <a name="input_name"></a> [name](#input\_name) | Input the name of stack | `string` | `""` | no |
| <a name="input_nat_multi_az"></a> [nat\_multi\_az](#input\_nat\_multi\_az) | Choose whether to have one NAT per AZ | `bool` | `false` | no |
| <a name="input_nat_single_az"></a> [nat\_single\_az](#input\_nat\_single\_az) | Choose whether to use only one NAT for all private subnets | `bool` | `false` | no |
| <a name="input_netbios_name_servers"></a> [netbios\_name\_servers](#input\_netbios\_name\_servers) | (Optional) List of NETBIOS name servers. | `list(string)` | `[]` | no |
| <a name="input_netbios_node_type"></a> [netbios\_node\_type](#input\_netbios\_node\_type) | (Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. | `number` | `2` | no |
| <a name="input_ntp_servers"></a> [ntp\_servers](#input\_ntp\_servers) | (Optional) List of NTP servers to configure. | `list(string)` | `[]` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The CIDR blocks of the Private subnets | `list(string)` | `[]` | no |
| <a name="input_propagating_vgws"></a> [propagating\_vgws](#input\_propagating\_vgws) | (Optional) A list of virtual gateways for propagation. | `list(string)` | `[]` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The CIDR blocks of the public subnets | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) Enter region where you are deploying resources | `string` | n/a | yes |
| <a name="input_tag_env"></a> [tag\_env](#input\_tag\_env) | Enter the name of the environment used by the resources | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | (Required) The type of traffic to capture. Valid values: `ACCEPT`,`REJECT`, `ALL`. | `string` | `"ALL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of VPC |
| <a name="output_default_network_acl_id"></a> [default\_network\_acl\_id](#output\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation |
| <a name="output_default_route_table_id"></a> [default\_route\_table\_id](#output\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation |
| <a name="output_enable_classiclink"></a> [enable\_classiclink](#output\_enable\_classiclink) | Whether or not the VPC has Classiclink enabled |
| <a name="output_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#output\_enable\_dns\_hostnames) | Whether or not the VPC has DNS hostname support |
| <a name="output_enable_dns_support"></a> [enable\_dns\_support](#output\_enable\_dns\_support) | Whether or not the VPC has DNS support |
| <a name="output_flow_logs_arn"></a> [flow\_logs\_arn](#output\_flow\_logs\_arn) | The ARN of the Flow Log. |
| <a name="output_flow_logs_id"></a> [flow\_logs\_id](#output\_flow\_logs\_id) | The Flow Log ID |
| <a name="output_flow_logs_tags_all"></a> [flow\_logs\_tags\_all](#output\_flow\_logs\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [default\_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPC |
| <a name="output_instance_tenancy"></a> [instance\_tenancy](#output\_instance\_tenancy) | Tenancy of instances spin up within VPC. |
| <a name="output_internal_subnet_id"></a> [internal\_subnet\_id](#output\_internal\_subnet\_id) | The IDs of the internal private subnets |
| <a name="output_ipv6_association_id"></a> [ipv6\_association\_id](#output\_ipv6\_association\_id) | The association ID for the IPv6 CIDR block. |
| <a name="output_ipv6_cidr_block_network_border_group"></a> [ipv6\_cidr\_block\_network\_border\_group](#output\_ipv6\_cidr\_block\_network\_border\_group) | The Network Border Group Zone name |
| <a name="output_isolated_subnet_id"></a> [isolated\_subnet\_id](#output\_isolated\_subnet\_id) | The IDs of the isolated private subnets |
| <a name="output_main_route_table_id"></a> [main\_route\_table\_id](#output\_main\_route\_table\_id) | The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an `aws_main_route_table_association`. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The ID of the AWS account that owns the VPC. |
| <a name="output_private_eks_subnet_id"></a> [private\_eks\_subnet\_id](#output\_private\_eks\_subnet\_id) | The IDs of the private eks subnets |
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | The IDs of the private subnets |
| <a name="output_public_eks_subnet_id"></a> [public\_eks\_subnet\_id](#output\_public\_eks\_subnet\_id) | The IDs of the public eks subnets |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | The IDs of the public subnets |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
