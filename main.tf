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

resource "aws_route53_record" "records" {
  for_each = var.records

  zone_id = var.create_hosted_zone ? aws_route53_zone.this[0].id : var.hosted_zone_id

  allow_overwrite = try(each.value.allow_overwrite, null)
  name            = try(each.key, null)
  records         = try(each.value.records, null)
  ttl             = try(each.value.ttl, null)
  type            = try(each.value.type, null)

  dynamic "alias" {
    for_each = each.value.alias[*]
    content {
      name                   = alias.value.name                   # each.value.alias.name
      zone_id                = alias.value.zone_id                # each.value.alias.zone_id
      evaluate_target_health = alias.value.evaluate_target_health # each.value.alias.evaluate_target_health
    }
  }
}
