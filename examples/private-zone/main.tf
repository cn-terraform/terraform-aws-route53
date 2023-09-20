module "base-network" {
  source     = "cn-terraform/networking/aws"
  version    = "3.0.0"
  cidr_block = "192.168.0.0/16"
  single_nat = true
  public_subnets = {
    a = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.0.0/19"
    }
    b = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.32.0/19"
    }
    c = {
      availability_zone = "us-east-1c"
      cidr_block        = "192.168.64.0/19"
    }
    d = {
      availability_zone = "us-east-1d"
      cidr_block        = "192.168.96.0/19"
    }
  }
  private_subnets = {
    a = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.128.0/19"
    }
    b = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.160.0/19"
    }
    c = {
      availability_zone = "us-east-1c"
      cidr_block        = "192.168.192.0/19"
    }
    d = {
      availability_zone = "us-east-1d"
      cidr_block        = "192.168.224.0/19"
    }
  }
}

module "private" {
  source = "../../"

  create_hosted_zone = true
  hosted_zone_name   = "example.com"

  vpc = {
    vpc_id = module.base-network.id
  }
}
