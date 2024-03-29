[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-vpc/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-vpc.svg)](https://github.com/boldlink/terraform-aws-vpc/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-vpc/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-vpc/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# Terraform  module example of VPC with singl NAT gateway

Development, or even Testing environments often don't require highly available network connectivity to the internet, this example shows how to deploy a VPC with a single NAT gateway (single AZ) ideal for non-production environments.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.50.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_single_nat_vpc"></a> [single\_nat\_vpc](#module\_single\_nat\_vpc) | ./../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR block of the vpc | `string` | `"10.1.0.0/16"` | no |
| <a name="input_name"></a> [name](#input\_name) | The stack name | `string` | `"single-nat-vpc-example"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The resource tags to be applied | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "LayerId": "Example",<br>  "LayerName": "Example",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform-registry"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outputs"></a> [outputs](#output\_outputs) | Module outputs |
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

#### BOLDLink-SIG 2023
