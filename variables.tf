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

#------------------------------------------------------------------------------
# Hosted Zone records
#------------------------------------------------------------------------------
variable "records" {
  type = map(object({
    # (Optional) An alias block. Conflicts with ttl and records.
    alias = optional(object({
      # (Required) DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone.
      name = string
      # (Required) Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone. See resource_elb.zone_id for example.
      zone_id = string
      # (Required) Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set. Some resources have special requirements, see related part of documentation.
      evaluate_target_health = bool
    }))

    # (Optional) Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments.
    allow_overwrite = optional(bool)

    # (Optional) The health check the record should be associated with.
    health_check_id = optional(string)

    # (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g., "first255characters\"\"morecharacters").
    records = optional(list(string))

    # (Required for non-alias records) The TTL of the record.
    ttl = optional(number)

    # (Required) The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
    type = string
  }))
  description = "(Optional) Map of records to add to the hosted zone"
  default     = {}
}

# TODO - Support routing policies

# set_identifier - (Optional) Unique identifier to differentiate records with routing policies from one another. Required if using cidr_routing_policy, failover_routing_policy, geolocation_routing_policy, latency_routing_policy, multivalue_answer_routing_policy, or weighted_routing_policy.

# cidr_routing_policy - (Optional) A block indicating a routing policy based on the IP network ranges of requestors. Conflicts with any other routing policy. Documented below.
# CIDR routing policies support the following:
# collection_id - (Required) The CIDR collection ID. See the aws_route53_cidr_collection resource for more details.
# location_name - (Required) The CIDR collection location name. See the aws_route53_cidr_location resource for more details. A location_name with an asterisk "*" can be used to create a default CIDR record. collection_id is still required for default record.

# failover_routing_policy - (Optional) A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. Documented below.
# Failover routing policies support the following:
# type - (Required) PRIMARY or SECONDARY. A PRIMARY record will be served if its healthcheck is passing, otherwise the SECONDARY will be served. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-configuring-options.html#dns-failover-failover-rrsets

# geolocation_routing_policy - (Optional) A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. Documented below.
# Geolocation routing policies support the following:
# continent - A two-letter continent code. See http://docs.aws.amazon.com/Route53/latest/APIReference/API_GetGeoLocation.html for code details. Either continent or country must be specified.
# country - A two-character country code or * to indicate a default resource record set.
# subdivision - (Optional) A subdivision code for a country.

# latency_routing_policy - (Optional) A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. Documented below.
# Latency routing policies support the following:
# region - (Required) An AWS region from which to measure latency. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-latency

# weighted_routing_policy - (Optional) A block indicating a weighted routing policy. Conflicts with any other routing policy. Documented below.
# Weighted routing policies support the following:
# weight - (Required) A numeric value indicating the relative weight of the record. See http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-weighted.

# multivalue_answer_routing_policy - (Optional) Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy.
