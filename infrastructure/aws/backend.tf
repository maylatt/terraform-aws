# Backend configuration require a AWS storage bucket
terraform {
  backend "s3" {
    bucket = "a3-terraform-backend-827486940322"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}