
variable "resource_records" {
  description = "Google it"
  type = list(object({
    data = list(string)
    name = string
    ttl  = number
    type = string
  }))
  default = []
}

variable "common_zone_id" {
  description = "Zone ID of hosted zone common to all records"
}

resource "aws_route53_record" "my_dns_records" {
  # for_each = var.resource_records
  count = length(var.resource_records)

  allow_overwrite = false

  name    = var.resource_records[count.index].name
  type    = var.resource_records[count.index].type
  zone_id = var.common_zone_id
  records = var.resource_records[count.index].data
}

output "route53_records" {
  value = aws_route53_record.my_dns_records
}
