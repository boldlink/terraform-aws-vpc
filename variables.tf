/*
VPC
*/

variable "cidr_block" {
  type        = string
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length`."
  default     = null
}

variable "instance_tenancy" {
  type        = string
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is `default`, which makes your instances shared on the host. Using either of the other options (`dedicated` or `host`) costs at least `$2/hr`."
  default     = "default"
}

variable "ipv4_ipam_pool_id" {
  type        = string
  description = "(Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR. IPAM is a VPC feature that you can use to automate your IP address management workflows including assigning, tracking, troubleshooting, and auditing IP addresses across AWS Regions and accounts. Using IPAM you can monitor IP address usage throughout your AWS Organization."
  default     = null
}

variable "ipv4_netmask_length" {
  type        = number
  description = "(Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a `ipv4_ipam_pool_id`."
  default     = null
}

variable "ipv6_cidr_block" {
  type        = string
  description = "(Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using `ipv6_netmask_length`."
  default     = null
}

variable "ipv6_ipam_pool_id" {
  type        = string
  description = "(Optional) IPAM Pool ID for a IPv6 pool. Conflicts with `assign_generated_ipv6_cidr_block`."
  default     = null
}

variable "ipv6_netmask_length" {
  type        = number
  description = "(Optional) Netmask length to request from IPAM Pool. Conflicts with ipv6_cidr_block. This can be omitted if IPAM pool as a allocation_default_netmask_length set. Valid values: `56`."
  default     = null
}

variable "ipv6_cidr_block_network_border_group" {
  type        = string
  description = "(Optional) By default when an IPv6 CIDR is assigned to a VPC a default ipv6_cidr_block_network_border_group will be set to the region of the VPC. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones."
  default     = null
}

variable "enable_dns_support" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults `true`."
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults `false`."
  default     = false
}

variable "enable_classiclink" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the [ClassicLink documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html) for more information. Defaults false."
  default     = false
}

variable "enable_classiclink_dns_support" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  default     = false
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false. Conflicts with `ipv6_ipam_pool_id`"
  default     = false
}

/*
VPC flow logs
*/

variable "traffic_type" {
  type        = string
  description = "(Required) The type of traffic to capture. Valid values: `ACCEPT`,`REJECT`, `ALL`."
  default     = "ALL"
}

variable "flow_log_eni_id" {
  type        = string
  description = "(Optional) Elastic Network Interface ID to attach to"
  default     = null
}

variable "log_destination_type" {
  type        = string
  description = "(Optional) The type of the logging destination. Valid values: `cloud-watch-logs`, `s3`. Default: `cloud-watch-logs`."
  default     = "cloud-watch-logs"
}

variable "flow_log_subnet_id" {
  type        = string
  description = "(Optional) Subnet ID to attach to"
  default     = null
}

variable "log_format" {
  type        = string
  description = "(Optional) The fields to include in the flow log record, in the order in which they should appear."
  default     = null
}

variable "max_aggregation_interval" {
  type        = number
  description = "(Optional) The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60 seconds (1 minute) or 600 seconds (10 minutes)`. Default: `600`."
  default     = 600
}

variable "destination_options" {
  type        = map(string)
  description = "(Optional) Describes the destination options for a flow log."
  default     = {}
}

/*
DHCP options Set
*/

variable "dhcp_domain_name" {
  type        = string
  description = "(Optional) the suffix domain name to use by default when resolving non Fully Qualified Domain Names. In other words, this is what ends up being the `search` value in the `/etc/resolv.conf` file."
  default     = null
}

variable "domain_name_servers" {
  type        = list(string)
  description = "(Optional) List of name servers to configure in /etc/resolv.conf. If you want to use the default AWS nameservers you should set this to `AmazonProvidedDNS`."
  default     = ["AmazonProvidedDNS"]
}

variable "ntp_servers" {
  type        = list(string)
  description = "(Optional) List of NTP servers to configure."
  default     = []
}

variable "netbios_name_servers" {
  type        = list(string)
  description = "(Optional) List of NETBIOS name servers."
  default     = []
}

variable "netbios_node_type" {
  type        = number
  description = "(Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network."
  default     = 2
}

/*
Publiс routes
*/

variable "propagating_vgws" {
  type        = list(string)
  description = "(Optional) A list of virtual gateways for propagation."
  default     = []
}

/*
Subnets & Other resources
*/

variable "public_subnets" {
  type        = list(string)
  description = "The CIDR blocks of the public subnets"
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "The CIDR blocks of the Private subnets"
  default     = []
}

variable "isolated_subnets" {
  type        = list(string)
  description = "The CIDR blocks of the Private Isolated subnets, that is, subnets without internet access."
  default     = []
}

variable "database_subnets" {
  type        = list(string)
  description = "The CIDR blocks of the database subnets"
  default     = []
}

variable "eks_public_subnets" {
  type        = list(string)
  description = "The CIDR blocks of the Public EKS subnets"
  default     = []
}

variable "eks_private_subnets" {
  type        = list(string)
  description = "The CIDR blocks of the Private EKS subnets"
  default     = []
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AZs of the subnets"
  default     = []
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is `false`."
  default     = false
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is `false`."
  default     = false
}

variable "nat_multi_az" {
  type        = bool
  description = "Choose whether to have one NAT per AZ"
  default     = false
}

variable "create_database_subnet_group" {
  type        = bool
  description = "Choose whether to create database subnet group."
  default     = false
}

variable "create_docdb_subnet_group" {
  type        = bool
  description = "Choose whether to create DocumentDB Subnet Group."
  default     = false
}

variable "nat_single_az" {
  type        = bool
  description = "Choose whether to use only one NAT for all private subnets"
  default     = false
}

variable "create_nat_gateway" {
  type        = bool
  description = "Specify whether you want to create NAT Gateway(s) or not"
  default     = false
}

variable "tag_env" {
  type        = string
  description = "Enter the name of the environment used by the resources"
  default     = null
}

variable "name" {
  type        = string
  description = "Input the name of stack"
  default     = null
}

variable "account" {
  type        = string
  description = "(Required) Account ID to use to create resources"
}

variable "region" {
  type        = string
  description = "(Required) Enter region where you are deploying resources"
}

variable "other_tags" {
  type        = map(string)
  description = "A map of addition tags to apply to the resources created"
  default     = {}
}

variable "cluster_name" {
  type        = string
  description = "Input name of EKS Cluster. Provide this when creating EKS subnets"
  default     = "none"
}
