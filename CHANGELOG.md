# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- Add Changelog document
- Fix endpoint routing
- Automate the releases through Github Actions
- Automate README CHANGELOG update through Github Actions
- Automate pre-commit through Github Actions
- Automate module security scanning through Github Actions
- Automate module testing with deploy through self-hosted Github Actions

## [2.0.2] - 2022-02-03
### Add additonal network configurations
- Rename isolated to internal subnets -d
- Add security group for VPC endpoints -d
- Remove Database and DocDb subnets -d
- Add a list of all service endpoints to example
- Add locals to reduce the nr of required inputs
- Add conditional inputs for the Single or Multi NatGw
- Breakdown main.tf into multiple files

## [2.0.1] - 2022-02-03
### Add additonal network configurations
- Add VPC Endpoints module
- Add VPC IPAM module
- Add Multi NatGw support
- Update examples

## [2.0.0] - 2022-02-03
### Add full VPC with single NatGw

## [1.0.0] - 2022-02-03
### Initial commit with only the VPC resource


[Unreleased]: https://github.com/cko-core-terraform/terraform-aws-template/compare/2.0.2...HEAD
[2.0.2]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/2.0.2
[2.0.1]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/2.0.1
[2.0.0]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/2.0.0
[1.0.0]: https://github.com/boldlink/terraform-aws-vpc/releases/tag/1.0.0
