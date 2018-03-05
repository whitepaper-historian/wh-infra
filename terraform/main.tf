provider "aws" {
  profile    = "whinfra"
  region     = "${var.region}"
}

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "r" {
  backend = "s3"
  config {
    bucket = "${var.tfstate_bucket}"
    key = "common/terraform.tfstate"    
    region = "${var.region}"
  }
}