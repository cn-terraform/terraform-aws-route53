#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
# variable "name_prefix" {
#   type        = string
#   description = "Name prefix for resources on AWS"
# }

# variable "tags" {
#   type        = map(string)
#   default     = {}
#   description = "Resource tags"
# }

#------------------------------------------------------------------------------
# AWS REGION
#------------------------------------------------------------------------------
# variable "region" {
#   type        = string
#   description = "AWS Region the infrastructure is hosted in"
# }

#------------------------------------------------------------------------------
# Hosted Zone variables
#------------------------------------------------------------------------------
variable "create_hosted_zone" {
  type        = bool
  description = "(Optional) If true a hosted zone will be created"
  default     = true
}

variable "hosted_zone_id" {
  type        = string
  description = "(Optional) Required when create_hosted_zone is false. This is the hosted zone where records will be created."
  default     = null
}

variable "hosted_zone_name" {
  type        = string
  description = "(Optional) Required when create_hosted_zone is true. This is the name of the hosted zone."
  default     = null
}

variable "comment" {
  type        = string
  description = "(Optional) A comment for the hosted zone. Defaults to 'Managed by Terraform'"
  default     = null
}

variable "delegation_set_id" {
  type        = string
  description = "(Optional) The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones."
  default     = null
}

variable "force_destroy" {
  type        = bool
  description = "(Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  default     = true
}

variable "hosted_zone_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the zone. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "vpc" {
  type = object({
    # (Required) ID of the VPC to associate.
    vpc_id = string
    # (Optional) Region of the VPC to associate. Defaults to AWS provider region.
    vpc_region = optional(string)
  })
  description = "(Optional) Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation_set_id argument in this resource and any aws_route53_zone_association resource specifying the same zone ID."
  default     = null
}
