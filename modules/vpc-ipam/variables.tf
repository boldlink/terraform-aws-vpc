variable "ipam_description" {
  type        = string
  description = "(Optional) A description for the IPAM."
  default     = null
}

variable "operating_regions" {
  type        = map(string)
  description = "(Required) Determines which locales can be chosen when you create pools. Locale is the Region where you want to make an IPAM pool available for allocations. You can only create pools with locales that match the operating Regions of the IPAM. You can only create VPCs from a pool whose locale matches the VPC's Region. You specify a region using the [`region_name`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam#operating_regions) parameter. You must set your provider block region as an operating_region."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

##########################################
## AWS vpc ipam organization admin account
##########################################

variable "enable_ipam_organization_admin_account" {
  type        = bool
  description = "Choose whether to enable the IPAM Service and promote a delegated administrator."
  default     = false
}

variable "delegated_admin_account_id" {
  type        = string
  description = "Enables the IPAM Service and promotes a delegated administrator"
  default     = null
}

##########################################
## aws vpc ipam pool
##########################################

variable "address_family" {
  type        = string
  description = "(Optional) The IP protocol assigned to this pool. You must choose either IPv4 or IPv6 protocol for a pool."
  default     = null
}

variable "publicly_advertisable" {
  type        = bool
  description = "(Optional) Defines whether or not IPv6 pool space is publicly advertisable over the internet. This option is not available for IPv4 pool space."
  default     = false
}

variable "allocation_default_netmask_length" {
  type        = string
  description = "(Optional) A default netmask length for allocations added to this pool. If, for example, the CIDR assigned to this pool is 10.0.0.0/8 and you enter 16 here, new allocations will default to 10.0.0.0/16 (unless you provide a different netmask value when you create the new allocation)."
  default     = null
}

variable "allocation_max_netmask_length" {
  type        = string
  description = "(Optional) The maximum netmask length that will be required for CIDR allocations in this pool."
  default     = null
}

variable "allocation_min_netmask_length" {
  type        = number
  description = "(Optional) The minimum netmask length that will be required for CIDR allocations in this pool."
  default     = null
}

variable "allocation_resource_tags" {
  type        = map(string)
  description = "(Optional) Tags that are required for resources that use CIDRs from this IPAM pool. Resources that do not have these tags will not be allowed to allocate space from the pool. If the resources have their tags changed after they have allocated space or if the allocation tagging requirements are changed on the pool, the resource may be marked as noncompliant."
  default     = {}
}

variable "auto_import" {
  type        = string
  description = "(Optional) If you include this argument, IPAM automatically imports any VPCs you have in your scope that fall within the CIDR range in the pool."
  default     = null
}

variable "aws_service" {
  type        = string
  description = "(Optional) Limits which AWS service the pool can be used in. Only useable on public scopes. Valid Values: `ec2`."
  default     = null
}

variable "ipam_pool_description" {
  type        = string
  description = "(Optional) A description for the IPAM pool."
  default     = null
}

variable "locale" {
  type        = string
  description = "(Optional) The locale in which you would like to create the IPAM pool. Locale is the Region where you want to make an IPAM pool available for allocations. You can only create pools with locales that match the operating Regions of the IPAM. You can only create VPCs from a pool whose locale matches the VPC's Region. Possible values: Any AWS region, such as `eu-west-1`."
  default     = null
}

variable "source_ipam_pool_id" {
  type        = string
  description = "(Optional) The ID of the source IPAM pool. Use this argument to create a child pool within an existing pool."
  default     = null
}

##########################################
## aws vpc ipam pool cidr
##########################################

variable "ipam_pool_cidr" {
  type        = string
  description = "(Optional) The CIDR you want to assign to the pool."
  default     = null
}

variable "cidr_authorization_context" {
  type        = map(string)
  description = "(Optional) A signed document that proves that you are authorized to bring the specified IP address range to Amazon using BYOIP. This is not stored in the state file. See [cidr_authorization_context](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr#cidr_authorization_context) for more information."
  default     = {}
}

##########################################
## aws vpc ipam pool cidr allocation
##########################################

variable "pool_allocation_cidr" {
  type        = string
  description = "(Optional) The CIDR you want to assign to the pool."
  default     = null
}

variable "pool_allocation_description" {
  type        = string
  description = "(Optional) The description for the allocation."
  default     = null
}

variable "pool_allocation_disallowed_cidrs" {
  type        = list(string)
  description = "(Optional) Exclude a particular CIDR range from being returned by the pool."
  default     = []
}

variable "pool_allocation_netmask_length" {
  type        = number
  description = "(Optional) The netmask length of the CIDR you would like to allocate to the IPAM pool. Valid Values: `0-32`."
  default     = 0
}

##########################################
## aws vpc ipam preview next cidr
##########################################

variable "ipam_preview_netmask_length" {
  type        = number
  description = "(Optional) The netmask length of the CIDR you would like to preview from the IPAM pool."
  default     = 0
}

variable "ipam_preview_disallowed_cidrs" {
  type        = list(string)
  description = "(Optional) Exclude a particular CIDR range from being returned by the pool."
  default     = []
}

##########################################
## aws vpc ipam scope
##########################################

variable "ipam_scope_description" {
  type        = string
  description = "(Optional) A description for the scope you're creating."
  default     = null
}
