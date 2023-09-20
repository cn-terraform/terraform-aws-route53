# Required to test private zone
resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"
}

module "private" {
  source = "../../"

  create_hosted_zone = true
  hosted_zone_name   = "example.com"

  vpc = {
    vpc_id = aws_vpc.vpc.id
  }

  records = {
    "test.a" = {
      type    = "A"
      ttl     = 60
      records = ["1.1.1.1"]
    }

    "test.aaaa" = {
      type    = "AAAA"
      ttl     = 60
      records = ["2001:db8::1"]
    }

    "test.alias" = {
      type = "A"
      alias = {
        name                   = "dns_name"
        zone_id                = "zone_id"
        evaluate_target_health = true
      }
    }

    "test.cname" = {
      type    = "CNAME"
      ttl     = 60
      records = ["example.com"]
    }

    "test.mx" = {
      type    = "MX"
      ttl     = 60
      records = ["10 mail.example.com"]
    }

    "test.ns" = {
      type    = "NS"
      ttl     = 60
      records = ["ns-123.awsdns-45.net", "ns-678.awsdns-91.com"]
    }

    "test.soa" = {
      type    = "SOA"
      ttl     = 60
      records = ["ns.example.com admin.example.com 123 900 600 86400 3600"]
    }

    "test.txt" = {
      type    = "TXT"
      ttl     = 60
      records = ["This is a TXT record"]
    }
  }
}
