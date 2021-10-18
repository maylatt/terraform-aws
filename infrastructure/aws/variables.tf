variable "region_id" {
  default = "us-east-1"
}

variable "prefix" {
  default = "a3"
}

variable "account" {
  default = 827486940322
}

variable "database_name" {
  default = "onboarding-a3-"
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
  bucket_name          = "${local.prefix}-onboarding-terraform-${var.account}"
  lambda_function_name = "${local.prefix}_extract_data"
}
