# Backend configuration require a AWS storage bucket.
terraform {
  backend "s3" {
    bucket = local.backend_bucket
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
