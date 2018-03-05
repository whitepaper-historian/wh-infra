terraform {
  backend "s3" {
    bucket  = "wh-tf-state"
    region  = "us-east-1"
    profile = "whinfra"
  }
}
