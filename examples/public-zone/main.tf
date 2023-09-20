module "primary" {
  source = "../../"

  create_hosted_zone = true
  hosted_zone_name   = "example.com"
}
