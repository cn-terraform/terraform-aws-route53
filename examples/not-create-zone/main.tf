module "primary" {
  source = "../../"

  create_hosted_zone = false
  hosted_zone_name   = "example.com"
}
