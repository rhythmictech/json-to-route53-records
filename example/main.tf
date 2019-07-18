variable "region" {
  description = "AWS Region"
  type        = "string"
  default     = "us-east-1"
}

variable "route53_hosted_zone_name" {
  description = "Hosted Zone common to all the records"
  type        = "string"
  default     = ""
}

variable "resource_records_file_name" {
  description = "file name where all the DNS entries are stored"
  type        = "string"
  default     = "test.json"
}


provider "aws" {
  region = var.region
}

locals {
  # 
  file_name = "oforce_rackspace_dns_export.json"
}

data "aws_route53_zone" "zone_name" {
  name = var.route53_hosted_zone_name
}

module "resource_records" {
  # for testing
  source           = "../"

#   source           = "github.com/rhythmictech/json-to-route53-records.git?ref=v0.0.1"
  resource_records = jsondecode(file("${path.module}/${var.resource_records_file_name}"))
  common_zone_id   = data.aws_route53_zone.zone_name.zone_id
}

output "resource_records" {
  value = module.resource_records.route53_records
}
