resource "aws_route53_zone" "this" {
  count = var.create_hosted_zone ? 1 : 0

  name              = var.hosted_zone_name
  comment           = var.comment
  delegation_set_id = var.delegation_set_id
  force_destroy     = var.force_destroy
  tags              = var.hosted_zone_tags

  dynamic "vpc" {
    for_each = toset(var.vpc != null ? [var.vpc] : [])
    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }
}









# This resource supports the following arguments:

# zone_id - (Required) The ID of the hosted zone to contain this record.
# name - (Required) The name of the record.
# type - (Required) The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
# ttl - (Required for non-alias records) The TTL of the record.
# records - (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g., "first255characters\"\"morecharacters").
# set_identifier - (Optional) Unique identifier to differentiate records with routing policies from one another. Required if using cidr_routing_policy, failover_routing_policy, geolocation_routing_policy, latency_routing_policy, multivalue_answer_routing_policy, or weighted_routing_policy.
# health_check_id - (Optional) The health check the record should be associated with.
# alias - (Optional) An alias block. Conflicts with ttl & records. Documented below.
# cidr_routing_policy - (Optional) A block indicating a routing policy based on the IP network ranges of requestors. Conflicts with any other routing policy. Documented below.
# failover_routing_policy - (Optional) A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. Documented below.
# geolocation_routing_policy - (Optional) A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. Documented below.
# latency_routing_policy - (Optional) A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. Documented below.
# multivalue_answer_routing_policy - (Optional) Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy.
# weighted_routing_policy - (Optional) A block indicating a weighted routing policy. Conflicts with any other routing policy. Documented below.
# allow_overwrite - (Optional) Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments.
