# Route53 Terraform Module for AWS

This Terraform module creates the base networking infrastructure on AWS.

[![](https://github.com/cn-terraform/terraform-aws-route53/workflows/terraform/badge.svg)](https://github.com/cn-terraform/terraform-aws-route53/actions?query=workflow%3Aterraform)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-route53)](https://github.com/cn-terraform/terraform-aws-route53)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-route53)](https://github.com/cn-terraform/terraform-aws-route53)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-route53)](https://github.com/cn-terraform/terraform-aws-route53)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-route53)](https://github.com/cn-terraform/terraform-aws-route53)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-route53)](https://github.com/cn-terraform/terraform-aws-route53)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-route53/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

## Install pre commit hooks.

Pleas run this command right after cloning the repository.

        pre-commit install

For that you may need to install the folowwing tools:
* [Pre-commit](https://pre-commit.com/)
* [Terraform Docs](https://terraform-docs.io/)

In order to run all checks at any point run the following command:

        pre-commit run --all-files

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_comment"></a> [comment](#input\_comment) | (Optional) A comment for the hosted zone. Defaults to 'Managed by Terraform' | `string` | `null` | no |
| <a name="input_create_hosted_zone"></a> [create\_hosted\_zone](#input\_create\_hosted\_zone) | (Optional) If true a hosted zone will be created | `bool` | `true` | no |
| <a name="input_delegation_set_id"></a> [delegation\_set\_id](#input\_delegation\_set\_id) | (Optional) The ID of the reusable delegation set whose NS records you want to assign to the hosted zone. Conflicts with vpc as delegation sets can only be used for public zones. | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. | `bool` | `true` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | (Optional) Required when create\_hosted\_zone is false. This is the hosted zone where records will be created. | `string` | `null` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | (Optional) Required when create\_hosted\_zone is true. This is the name of the hosted zone. | `string` | `null` | no |
| <a name="input_hosted_zone_tags"></a> [hosted\_zone\_tags](#input\_hosted\_zone\_tags) | (Optional) A map of tags to assign to the zone. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_records"></a> [records](#input\_records) | (Optional) Map of records to add to the hosted zone | <pre>map(object({<br>    # (Optional) An alias block. Conflicts with ttl and records.<br>    alias = optional(object({<br>      # (Required) DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone.<br>      name = string<br>      # (Required) Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone. See resource_elb.zone_id for example.<br>      zone_id = string<br>      # (Required) Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set. Some resources have special requirements, see related part of documentation.<br>      evaluate_target_health = bool<br>    }))<br><br>    # (Optional) Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments.<br>    allow_overwrite = optional(bool)<br><br>    # (Optional) The health check the record should be associated with.<br>    health_check_id = optional(string)<br><br>    # (Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g., "first255characters\"\"morecharacters").<br>    records = optional(list(string))<br><br>    # (Required for non-alias records) The TTL of the record.<br>    ttl = optional(number)<br><br>    # (Required) The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.<br>    type = string<br>  }))</pre> | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | (Optional) Configuration block(s) specifying VPC(s) to associate with a private hosted zone. Conflicts with the delegation\_set\_id argument in this resource and any aws\_route53\_zone\_association resource specifying the same zone ID. | <pre>object({<br>    # (Required) ID of the VPC to associate.<br>    vpc_id = string<br>    # (Optional) Region of the VPC to associate. Defaults to AWS provider region.<br>    vpc_region = optional(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the Hosted Zone. |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | A list of name servers in associated (or default) delegation set. Find more about delegation sets in AWS docs. |
| <a name="output_primary_name_server"></a> [primary\_name\_server](#output\_primary\_name\_server) | The Route 53 name server that created the SOA record. |
| <a name="output_records"></a> [records](#output\_records) | ------------------------------------------------------------------------------ Records ------------------------------------------------------------------------------ |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The Hosted Zone ID. This can be referenced by zone records. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
