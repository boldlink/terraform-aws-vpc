[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-vpc/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-vpc.svg)](https://github.com/boldlink/terraform-aws-vpc/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS VPC internal subnets Terraform module

## Description

This module creates public subnets.

```hcl

```
## Documentation

[Amazon VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.multi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.single](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_nat_gateway.multi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.single](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The AZs to use to assign each subnet to | `list(string)` | n/a | yes |
| <a name="input_cidrs"></a> [cidrs](#input\_cidrs) | Public subnet ipv4 CIDR list | `list(string)` | n/a | yes |
| <a name="input_enable_private_subnets"></a> [enable\_private\_subnets](#input\_enable\_private\_subnets) | Activate private subnets module | `bool` | `false` | no |
| <a name="input_gateway_id"></a> [gateway\_id](#input\_gateway\_id) | The internet gateway ID to use on the route of the public internet traffic | `string` | n/a | yes |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | Set the standard behavior for public ip assignement on ec2 launch, for public subnets the default should be true | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The public subnet name | `string` | n/a | yes |
| <a name="input_nat"></a> [nat](#input\_nat) | Set your NatGw type, acceptable values are `single` for 1x NatGw only in a single AZ or `multi` for multiple NatGw's one per subnet | `string` | `null` | no |
| <a name="input_propagating_vgws"></a> [propagating\_vgws](#input\_propagating\_vgws) | (Optional) A list of virtual gateways for propagation. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The map of tags to add to module resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID to associate with | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | This value is used by the private subnets module to make it easier to search for the nat gateways through a specific tag | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Output all subnet information |
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
