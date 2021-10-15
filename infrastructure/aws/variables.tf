variable "region_id" {
  default = "us-east-1"
}

variable "prefix" {
  default = "a3"
}

variable "account" {
  default = 827486940322
}

variable "zones" {
  description = "Work Zones"
  type        = list(string)
  default = [
    "landing-zone",
    "processing-zone",
    "delivery-zone"
  ]
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Project      = "Datalake"
    ManagedBy    = "Terraform"
    Department   = "systems",
    Provider     = "A3DATA",
    Owner        = "Data Engineering"
    BusinessUnit = "Data"
    Billing      = "Infrastructure"
    Environment  = terraform.workspace
    UserEmail    = "rony@a3data.com.br"
  }
  bucket_names   = [for name in var.zones : "${local.prefix}-${name}-${var.account}"]
  database_names = [for name in var.zones : "dl_${name}"]
  bucket_functions = [
    "${local.prefix}-temp-functions-rony-${var.account}"
  ]
}
