variable "cidr_block" {
  type        = string
  description = "The CIDR block of the vpc"
  default     = "10.1.0.0/16"
}

variable "name" {
  type        = string
  description = "The stack name"
  default     = "complete-vpc-example"
}

variable "tags" {
  type        = map(string)
  description = "The resource tags to be applied"
  default = {
    Environment        = "example"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "Example"
    LayerId            = "Example"
  }
}

variable "sse_algorithm" {
  type        = string
  description = "(Required) The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`"
  default     = "AES256"
}

variable "force_destroy" {
  type        = bool
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = true
}

variable "sse_bucket_key_enabled" {
  type        = bool
  description = "(Optional) Whether or not to use Amazon S3 Bucket Keys for SSE-KMS."
  default     = true
}
