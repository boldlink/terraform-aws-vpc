[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-vpc/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-vpc.svg)](https://github.com/boldlink/terraform-aws-vpc/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# vpc-ipam

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc_ipam.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam) | resource |
| [aws_vpc_ipam_organization_admin_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_organization_admin_account) | resource |
| [aws_vpc_ipam_pool.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool_cidr.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |
| [aws_vpc_ipam_pool_cidr_allocation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr_allocation) | resource |
| [aws_vpc_ipam_preview_next_cidr.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_preview_next_cidr) | resource |
| [aws_vpc_ipam_scope.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_scope) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_family"></a> [address\_family](#input\_address\_family) | (Optional) The IP protocol assigned to this pool. You must choose either IPv4 or IPv6 protocol for a pool. | `string` | `null` | no |
| <a name="input_allocation_default_netmask_length"></a> [allocation\_default\_netmask\_length](#input\_allocation\_default\_netmask\_length) | (Optional) A default netmask length for allocations added to this pool. If, for example, the CIDR assigned to this pool is 10.0.0.0/8 and you enter 16 here, new allocations will default to 10.0.0.0/16 (unless you provide a different netmask value when you create the new allocation). | `string` | `null` | no |
| <a name="input_allocation_max_netmask_length"></a> [allocation\_max\_netmask\_length](#input\_allocation\_max\_netmask\_length) | (Optional) The maximum netmask length that will be required for CIDR allocations in this pool. | `string` | `null` | no |
| <a name="input_allocation_min_netmask_length"></a> [allocation\_min\_netmask\_length](#input\_allocation\_min\_netmask\_length) | (Optional) The minimum netmask length that will be required for CIDR allocations in this pool. | `number` | `null` | no |
| <a name="input_allocation_resource_tags"></a> [allocation\_resource\_tags](#input\_allocation\_resource\_tags) | (Optional) Tags that are required for resources that use CIDRs from this IPAM pool. Resources that do not have these tags will not be allowed to allocate space from the pool. If the resources have their tags changed after they have allocated space or if the allocation tagging requirements are changed on the pool, the resource may be marked as noncompliant. | `map(string)` | `{}` | no |
| <a name="input_auto_import"></a> [auto\_import](#input\_auto\_import) | (Optional) If you include this argument, IPAM automatically imports any VPCs you have in your scope that fall within the CIDR range in the pool. | `string` | `null` | no |
| <a name="input_aws_service"></a> [aws\_service](#input\_aws\_service) | (Optional) Limits which AWS service the pool can be used in. Only useable on public scopes. Valid Values: `ec2`. | `string` | `null` | no |
| <a name="input_cidr_authorization_context"></a> [cidr\_authorization\_context](#input\_cidr\_authorization\_context) | (Optional) A signed document that proves that you are authorized to bring the specified IP address range to Amazon using BYOIP. This is not stored in the state file. See [cidr\_authorization\_context](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr#cidr_authorization_context) for more information. | `map(string)` | `{}` | no |
| <a name="input_delegated_admin_account_id"></a> [delegated\_admin\_account\_id](#input\_delegated\_admin\_account\_id) | Enables the IPAM Service and promotes a delegated administrator | `string` | `null` | no |
| <a name="input_enable_ipam_organization_admin_account"></a> [enable\_ipam\_organization\_admin\_account](#input\_enable\_ipam\_organization\_admin\_account) | Choose whether to enable the IPAM Service and promote a delegated administrator. | `bool` | `false` | no |
| <a name="input_ipam_description"></a> [ipam\_description](#input\_ipam\_description) | (Optional) A description for the IPAM. | `string` | `null` | no |
| <a name="input_ipam_pool_cidr"></a> [ipam\_pool\_cidr](#input\_ipam\_pool\_cidr) | (Optional) The CIDR you want to assign to the pool. | `string` | `null` | no |
| <a name="input_ipam_pool_description"></a> [ipam\_pool\_description](#input\_ipam\_pool\_description) | (Optional) A description for the IPAM pool. | `string` | `null` | no |
| <a name="input_ipam_preview_disallowed_cidrs"></a> [ipam\_preview\_disallowed\_cidrs](#input\_ipam\_preview\_disallowed\_cidrs) | (Optional) Exclude a particular CIDR range from being returned by the pool. | `list(string)` | `[]` | no |
| <a name="input_ipam_preview_netmask_length"></a> [ipam\_preview\_netmask\_length](#input\_ipam\_preview\_netmask\_length) | (Optional) The netmask length of the CIDR you would like to preview from the IPAM pool. | `number` | `0` | no |
| <a name="input_ipam_scope_description"></a> [ipam\_scope\_description](#input\_ipam\_scope\_description) | (Optional) A description for the scope you're creating. | `string` | `null` | no |
| <a name="input_locale"></a> [locale](#input\_locale) | (Optional) The locale in which you would like to create the IPAM pool. Locale is the Region where you want to make an IPAM pool available for allocations. You can only create pools with locales that match the operating Regions of the IPAM. You can only create VPCs from a pool whose locale matches the VPC's Region. Possible values: Any AWS region, such as `eu-west-1`. | `string` | `null` | no |
| <a name="input_operating_regions"></a> [operating\_regions](#input\_operating\_regions) | (Required) Determines which locales can be chosen when you create pools. Locale is the Region where you want to make an IPAM pool available for allocations. You can only create pools with locales that match the operating Regions of the IPAM. You can only create VPCs from a pool whose locale matches the VPC's Region. You specify a region using the [`region_name`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam#operating_regions) parameter. You must set your provider block region as an operating\_region. | `map(string)` | n/a | yes |
| <a name="input_pool_allocation_cidr"></a> [pool\_allocation\_cidr](#input\_pool\_allocation\_cidr) | (Optional) The CIDR you want to assign to the pool. | `string` | `null` | no |
| <a name="input_publicly_advertisable"></a> [publicly\_advertisable](#input\_publicly\_advertisable) | (Optional) Defines whether or not IPv6 pool space is publicly advertisable over the internet. This option is not available for IPv4 pool space. | `bool` | `false` | no |
| <a name="input_source_ipam_pool_id"></a> [source\_ipam\_pool\_id](#input\_source\_ipam\_pool\_id) | (Optional) The ID of the source IPAM pool. Use this argument to create a child pool within an existing pool. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of IPAM |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IPAM |
| <a name="output_ipam_organization_admin_account_arn"></a> [ipam\_organization\_admin\_account\_arn](#output\_ipam\_organization\_admin\_account\_arn) | The Organizations ARN for the delegate account. |
| <a name="output_ipam_organization_admin_account_email"></a> [ipam\_organization\_admin\_account\_email](#output\_ipam\_organization\_admin\_account\_email) | The Organizations email for the delegate account. |
| <a name="output_ipam_organization_admin_account_id"></a> [ipam\_organization\_admin\_account\_id](#output\_ipam\_organization\_admin\_account\_id) | The Organizations member account ID that you want to enable as the IPAM account. |
| <a name="output_ipam_organization_admin_account_name"></a> [ipam\_organization\_admin\_account\_name](#output\_ipam\_organization\_admin\_account\_name) | The Organizations name for the delegate account. |
| <a name="output_ipam_organization_admin_account_service_principal"></a> [ipam\_organization\_admin\_account\_service\_principal](#output\_ipam\_organization\_admin\_account\_service\_principal) | The AWS service principal. |
| <a name="output_ipam_pool_arn"></a> [ipam\_pool\_arn](#output\_ipam\_pool\_arn) | Amazon Resource Name (ARN) of IPAM |
| <a name="output_ipam_pool_cidr_id"></a> [ipam\_pool\_cidr\_id](#output\_ipam\_pool\_cidr\_id) | The ID of the IPAM Pool Cidr concatenated with the IPAM Pool ID. |
| <a name="output_ipam_pool_id"></a> [ipam\_pool\_id](#output\_ipam\_pool\_id) | The ID of the IPAM |
| <a name="output_ipam_pool_state"></a> [ipam\_pool\_state](#output\_ipam\_pool\_state) | The ID of the IPAM |
| <a name="output_ipam_pool_tags_all"></a> [ipam\_pool\_tags\_all](#output\_ipam\_pool\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
| <a name="output_ipam_preview_cidr"></a> [ipam\_preview\_cidr](#output\_ipam\_preview\_cidr) | The previewed CIDR from the pool. |
| <a name="output_ipam_preview_id"></a> [ipam\_preview\_id](#output\_ipam\_preview\_id) | The ID of the preview. |
| <a name="output_ipam_scope_id"></a> [ipam\_scope\_id](#output\_ipam\_scope\_id) | The ID of the IPAM Scope. |
| <a name="output_ipam_scope_ipam_arn"></a> [ipam\_scope\_ipam\_arn](#output\_ipam\_scope\_ipam\_arn) | The ARN of the IPAM for which you're creating this scope. |
| <a name="output_ipam_scope_is_default"></a> [ipam\_scope\_is\_default](#output\_ipam\_scope\_is\_default) | Defines if the scope is the default scope or not. |
| <a name="output_ipam_scope_pool_count"></a> [ipam\_scope\_pool\_count](#output\_ipam\_scope\_pool\_count) | Count of pools under this scope |
| <a name="output_pool_allocation_id"></a> [pool\_allocation\_id](#output\_pool\_allocation\_id) | The ID of the allocation. |
| <a name="output_pool_allocation_resource_id"></a> [pool\_allocation\_resource\_id](#output\_pool\_allocation\_resource\_id) | The ID of the resource. |
| <a name="output_pool_allocation_resource_owner"></a> [pool\_allocation\_resource\_owner](#output\_pool\_allocation\_resource\_owner) | The owner of the resource. |
| <a name="output_pool_allocation_resource_type"></a> [pool\_allocation\_resource\_type](#output\_pool\_allocation\_resource\_type) | The type of the resource. |
| <a name="output_private_default_scope_id"></a> [private\_default\_scope\_id](#output\_private\_default\_scope\_id) | The ID of the IPAM's private scope. A scope is a top-level container in IPAM. Each scope represents an IP-independent network. Scopes enable you to represent networks where you have overlapping IP space. When you create an IPAM, IPAM automatically creates two scopes: public and private. The private scope is intended for private IP space. The public scope is intended for all internet-routable IP space. |
| <a name="output_public_default_scope_id"></a> [public\_default\_scope\_id](#output\_public\_default\_scope\_id) | The ID of the IPAM's public scope. A scope is a top-level container in IPAM. Each scope represents an IP-independent network. Scopes enable you to represent networks where you have overlapping IP space. When you create an IPAM, IPAM automatically creates two scopes: public and private. The private scope is intended for private IP space. The public scope is intended for all internet-routable IP space. |
| <a name="output_scope_count"></a> [scope\_count](#output\_scope\_count) | The number of scopes in the IPAM. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/docs/providers/aws/index#default_tags-configuration-block). |
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
