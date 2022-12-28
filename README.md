[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS VPC Terraform module

## Description

This terraform module creates a VPC, it is an opininated module of how to create a VPC - we only have 3 types of subnets:
- Public which are accessible directly from the internet and have an valid public IpV4/Ipv6 address.
- Private wich are not directly accessible from the internet but can reach the internet.
- Internal or isolated which can only be accessed by other devices on the same VPC.

Previous modules had repetitive code when it came to subnets, to resolve this we made the three types into sub-modules that can
be added until you run out of address spaces within the 3 types.

This module also supports VPC private subnets with a `single` Nat Gateway (ex. dev or single AZ ) or `multi` Nat Gateway (ex. prod with HA).

### LIMITATIONS and KNOWN ISSUES:
With releases `3.0.0` to `3.0.2` VPC Endpoints support has been removed and will be added in subsquent releases.


## Usage
Examples available [`here`](./examples)

*NOTE*: These examples use the latest version of this module

```console
module "minimum_vpc" {
  source                 = "./../../"
  name                   = "minimum-vpc-example"
  cidr_block             = "172.16.0.0/16"
  enable_public_subnets  = true
  enable_private_subnets = true

  public_subnets = {
    public1 = {
      cidrs                   = ["172.16.3.0/24", "172.16.4.0/24", "172.16.5.0/24"]
      map_public_ip_on_launch = true
      nat                     = "single"
    }
  }

  private_subnets = {
    private = {
      cidrs = ["172.16.6.0/24", "172.16.7.0/24", "172.16.8.0/24"]
    }
  }

  tags = {
    Environment        = "examples"
    "user::CostCenter" = "terraform-registry"
    department         = "operations"
    InstanceScheduler  = true
    Project            = "aws-vpc"
    Owner              = "hugo.almeida"
    LayerName          = "c300-aws-vpc"
    LayerId            = "c300"
  }
}
```
## Documentation

[Amazon VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.48.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_internal_subnets"></a> [internal\_subnets](#module\_internal\_subnets) | ./modules/internal/ | n/a |
| <a name="module_private_subnets"></a> [private\_subnets](#module\_private\_subnets) | ./modules/private/ | n/a |
| <a name="module_public_subnets"></a> [public\_subnets](#module\_public\_subnets) | ./modules/public/ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_default_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_flow_log.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_dhcp_options.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options) | resource |
| [aws_vpc_dhcp_options_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_nat_gateways.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/nat_gateways) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_generated_ipv6_cidr_block"></a> [assign\_generated\_ipv6\_cidr\_block](#input\_assign\_generated\_ipv6\_cidr\_block) | (Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false. Conflicts with `ipv6_ipam_pool_id` | `bool` | `false` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length`. | `string` | `null` | no |
| <a name="input_destination_options"></a> [destination\_options](#input\_destination\_options) | (Optional) Describes the destination options for a flow log. | `map(string)` | `{}` | no |
| <a name="input_dhcp_domain_name"></a> [dhcp\_domain\_name](#input\_dhcp\_domain\_name) | (Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the `search` value in the `/etc/resolv.conf` file. | `string` | `null` | no |
| <a name="input_domain_name_servers"></a> [domain\_name\_servers](#input\_domain\_name\_servers) | (Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to `AmazonProvidedDNS`. | `list(string)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults `false`. | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults `true`. | `bool` | `true` | no |
| <a name="input_enable_internal_subnets"></a> [enable\_internal\_subnets](#input\_enable\_internal\_subnets) | Activate internal subnets module | `bool` | `false` | no |
| <a name="input_enable_private_subnets"></a> [enable\_private\_subnets](#input\_enable\_private\_subnets) | Activate private subnets module | `bool` | `false` | no |
| <a name="input_enable_public_subnets"></a> [enable\_public\_subnets](#input\_enable\_public\_subnets) | Activate public subnets module | `bool` | `false` | no |
| <a name="input_flow_log_eni_id"></a> [flow\_log\_eni\_id](#input\_flow\_log\_eni\_id) | (Optional) Elastic Network Interface ID to attach to | `string` | `null` | no |
| <a name="input_flow_log_subnet_id"></a> [flow\_log\_subnet\_id](#input\_flow\_log\_subnet\_id) | (Optional) Subnet ID to attach to | `string` | `null` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | (Optional) A tenancy option for instances launched into the VPC. Default is `default`, which makes your instances shared on the host. Using either of the other options (`dedicated` or `host`) costs at least `$2/hr`. | `string` | `"default"` | no |
| <a name="input_internal_subnets"></a> [internal\_subnets](#input\_internal\_subnets) | Internal subnets settings map | `any` | `{}` | no |
| <a name="input_ipv4_ipam_pool_id"></a> [ipv4\_ipam\_pool\_id](#input\_ipv4\_ipam\_pool\_id) | (Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR. IPAM is a VPC feature that you can use to automate your IP address management workflows including assigning, tracking, troubleshooting, and auditing IP addresses across AWS Regions and accounts. Using IPAM you can monitor IP address usage throughout your AWS Organization. | `string` | `null` | no |
| <a name="input_ipv4_netmask_length"></a> [ipv4\_netmask\_length](#input\_ipv4\_netmask\_length) | (Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a `ipv4_ipam_pool_id`. | `number` | `null` | no |
| <a name="input_ipv6_cidr_block"></a> [ipv6\_cidr\_block](#input\_ipv6\_cidr\_block) | (Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using `ipv6_netmask_length`. | `string` | `null` | no |
| <a name="input_ipv6_cidr_block_network_border_group"></a> [ipv6\_cidr\_block\_network\_border\_group](#input\_ipv6\_cidr\_block\_network\_border\_group) | (Optional) By default when an IPv6 CIDR is assigned to a VPC a default ipv6\_cidr\_block\_network\_border\_group will be set to the region of the VPC. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones. | `string` | `null` | no |
| <a name="input_ipv6_ipam_pool_id"></a> [ipv6\_ipam\_pool\_id](#input\_ipv6\_ipam\_pool\_id) | (Optional) IPAM Pool ID for a IPv6 pool. Conflicts with `assign_generated_ipv6_cidr_block`. | `string` | `null` | no |
| <a name="input_ipv6_netmask_length"></a> [ipv6\_netmask\_length](#input\_ipv6\_netmask\_length) | (Optional) Netmask length to request from IPAM Pool. Conflicts with ipv6\_cidr\_block. This can be omitted if IPAM pool as a allocation\_default\_netmask\_length set. Valid values: `56`. | `number` | `null` | no |
| <a name="input_log_destination_type"></a> [log\_destination\_type](#input\_log\_destination\_type) | (Optional) The type of the logging destination. Valid values: `cloud-watch-logs`, `s3`. Default: `cloud-watch-logs`. | `string` | `"cloud-watch-logs"` | no |
| <a name="input_log_format"></a> [log\_format](#input\_log\_format) | (Optional) The fields to include in the flow log record, in the order in which they should appear. | `string` | `null` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Use this variable to override the default log group name `/aws/vpc/name` | `string` | `null` | no |
| <a name="input_logs_kms_key_id"></a> [logs\_kms\_key\_id](#input\_logs\_kms\_key\_id) | (Optional) The ARN of the KMS Key to use when encrypting log data. | `string` | `null` | no |
| <a name="input_max_aggregation_interval"></a> [max\_aggregation\_interval](#input\_max\_aggregation\_interval) | (Optional) The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60 seconds (1 minute) or 600 seconds (10 minutes)`. Default: `600`. | `number` | `600` | no |
| <a name="input_name"></a> [name](#input\_name) | Input the name of stack | `string` | n/a | yes |
| <a name="input_netbios_name_servers"></a> [netbios\_name\_servers](#input\_netbios\_name\_servers) | (Optional) List of NETBIOS name servers. | `list(string)` | `[]` | no |
| <a name="input_netbios_node_type"></a> [netbios\_node\_type](#input\_netbios\_node\_type) | (Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. | `number` | `2` | no |
| <a name="input_ntp_servers"></a> [ntp\_servers](#input\_ntp\_servers) | (Optional) List of NTP servers to configure. | `list(string)` | `[]` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Private subnets settings map | `any` | `{}` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Public subnets settings map | `any` | `{}` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | (Optional) Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | (Required) The type of traffic to capture. Valid values: `ACCEPT`,`REJECT`, `ALL`. | `string` | `"ALL"` | no |
| <a name="input_vpc_assume_policy"></a> [vpc\_assume\_policy](#input\_vpc\_assume\_policy) | Override the default vpc flow log group assume role policy | `string` | `null` | no |
| <a name="input_vpc_role_policy"></a> [vpc\_role\_policy](#input\_vpc\_role\_policy) | Override the default vpc flow log group role policy | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_network_acl_id"></a> [default\_network\_acl\_id](#output\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation |
| <a name="output_default_route_table_id"></a> [default\_route\_table\_id](#output\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation |
| <a name="output_enable_classiclink"></a> [enable\_classiclink](#output\_enable\_classiclink) | Whether or not the VPC has Classiclink enabled |
| <a name="output_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#output\_enable\_dns\_hostnames) | Whether or not the VPC has DNS hostname support |
| <a name="output_enable_dns_support"></a> [enable\_dns\_support](#output\_enable\_dns\_support) | Whether or not the VPC has DNS support |
| <a name="output_flow_logs_arn"></a> [flow\_logs\_arn](#output\_flow\_logs\_arn) | The ARN of the Flow Log. |
| <a name="output_flow_logs_id"></a> [flow\_logs\_id](#output\_flow\_logs\_id) | The Flow Log ID |
| <a name="output_flow_logs_tags_all"></a> [flow\_logs\_tags\_all](#output\_flow\_logs\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [default\_tags configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_instance_tenancy"></a> [instance\_tenancy](#output\_instance\_tenancy) | Tenancy of instances spin up within VPC. |
| <a name="output_ipv6_association_id"></a> [ipv6\_association\_id](#output\_ipv6\_association\_id) | The association ID for the IPv6 CIDR block. |
| <a name="output_ipv6_cidr_block_network_border_group"></a> [ipv6\_cidr\_block\_network\_border\_group](#output\_ipv6\_cidr\_block\_network\_border\_group) | The Network Border Group Zone name |
| <a name="output_main_route_table_id"></a> [main\_route\_table\_id](#output\_main\_route\_table\_id) | The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an `aws_main_route_table_association`. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | The ID of the AWS account that owns the VPC. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | Amazon Resource Name (ARN) of VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

### Supporting resources:

The example stacks are used by BOLDLink developers to validate the modules by building an actual stack on AWS.

Some of the modules have dependencies on other modules (ex. Ec2 instance depends on the VPC module) so we create them
first and use data sources on the examples to use the stacks.

Any supporting resources will be available on the `tests/supportingResources` and the lifecycle is managed by the `Makefile` targets.

Resources on the `tests/supportingResources` folder are not intended for demo or actual implementation purposes, and can be used for reference.

### Makefile
The makefile contained in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```


#### BOLDLink-SIG 2022
