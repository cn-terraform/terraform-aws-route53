#------------------------------------------------------------------------------
# Hosted Zone variables
#------------------------------------------------------------------------------
output "arn" {
  description = "The Amazon Resource Name (ARN) of the Hosted Zone."
  value       = var.create_hosted_zone ? aws_route53_zone.this[0].arn : null
}

output "zone_id" {
  description = "The Hosted Zone ID. This can be referenced by zone records."
  value       = var.create_hosted_zone ? aws_route53_zone.this[0].zone_id : null
}

output "name_servers" {
  description = "A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs."
  value       = var.create_hosted_zone ? aws_route53_zone.this[0].name_servers : null
}

output "primary_name_server" {
  description = "The Route 53 name server that created the SOA record."
  value       = var.create_hosted_zone ? aws_route53_zone.this[0].primary_name_server : null
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = var.create_hosted_zone ? aws_route53_zone.this[0].tags_all : null
}
