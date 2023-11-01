# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- fix: count conditional for creating routes for NAT Gateway brings an error when no natgateway is specified, i.e neither "single" nor "multi" is specified. This in turn requires two deployments to remove unwanted Nat Gateway
- fix: Remove `enable_private_subnets` variable from public subnets module and instead add a condition in private subnets module
- feat: Improve the documentation and examples for the subnets submodules (public; private; internal)
- feat: Improve the documentation and examples for the vpc-ipam sub module
- feat: Add the option to set as default VPC
- feat: Re-enable vpc logs export to s3
- feat: Add KMS support for s3 and logs group
- feat: support for public or private Nat Gateways
- feat: Public Subnets module - use one resource block for both the single and multi-nat gateways if possible
- feat: Private Subnets module - Use a single route resource for both single and multi gateways option
- feat: Allow to attach an existing eip to the nat gateway(s)
- feat: Remove the data source for the nat gw discovery and make it an option on the private module to remove dependencies
- feat: Test and add to complete example ipv6 support
- fix: CKV2_AWS_19: "Ensure that all EIP addresses allocated to a VPC are attached to EC2 instances"
- feat: Add egress only internet gateway support

## [3.2.0] - 2023-11-1
### Description
- feat: Add ipV6 support and example
- fix: CKV_TF_1 Ensure Terraform module sources use a commit hash

## [3.1.0] - 2023-9-12
### Description
- feat: Added subnet IDs to the output. Initially the IDs had to be obtained using data sources where they were required in the same deployment
- feat: removed unused vpc endpoints submodule

## [3.0.4] - 2023-5-26
### Description
- fix: removed deprecated output `enable_classiclink`
- fix: removed deprecated attribute `vpc` in `aws_eip` resource.

## [3.0.3] - 2023-03-02
### Description
- fix: Don't create the iam role when `log_destination_type == "s3"

## [3.0.2] - 2022-12-27
### Description
- fix: Private subnets required to be created after the public subnets which required two deployments. This required that you deploy a vpc with private subnets in two stages so you can deploy multiple subnet groups using `var.enable_private_subnets` which were by default set to `false` and which must both be set to `true` to create the private subnets, example of the output you get when there are no nat_gateways.
- fix/bug: When switching between `single` and `multi` NatGw's configuration the private subnets routes were not immediately updated requiring to re-run stack after the creation of the new NatGw(s) to properly update the routes - this would cause downtime to any private networks devices.

## [3.0.1] - 2022-09-29
### Description
- fix: Remove depricated `enable_classiclink`
- fix: CKV2_AWS_12: "Ensure the default security group of every VPC restricts all traffic"
- feat: update github action workflow
- feat: update gitignore
- feat: Add `SECURITY.md`
- feat: update Makefile

## [3.0.0] - 2022-06-24
### Description
- feat: Add the VPC name prefix in front of the subnets names for filtering and easier visual identification.
- feat: Add name override option for log group and s3 bucket default name.
- feat: Add additional security to s3 bucket for logging.
- feat: Create modules for the 3 types of subnets you can have in your VPC, public, private or internal/isolated
- feat: You use one variable to define the nr of nat gateways - var.nat with either `single` or `multi`
- feat: Add pre-commit and additional support files
- feat: Add checkov.yml config file for skipping CKV2_AWS_12

## [2.0.3] - 2022-04-22
### Description
- Added 2nd option (OR) for creation of rt

## [2.0.2] - 2022-04-05
### Description
- fix: Correct pointing to terraform registry

## [2.0.1] - 2022-04-01
### Description
- Add the vpc-endpoints and the vpc-ipam modules

## [2.0.0] - 2022-03-25
### Description
- Add Public Private and database subnets

## [1.0.0] - 2022-03-14
### Description
- Stand alone VPC created only with default security


[Unreleased]: https://github.com/boldlink/terraform-aws-vpc/compare/3.1.0...HEAD

[3.1.0]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/3.1.0
[3.0.4]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/3.0.4
[3.0.3]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/3.0.3
[3.0.2]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/3.0.2
[3.0.1]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/3.0.1
[3.0.0]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/3.0.0
[2.0.3]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/2.0.3
[2.0.2]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/2.0.2
[2.0.1]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/2.0.1
[2.0.0]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/2.0.0
[1.0.0]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/1.0.0
