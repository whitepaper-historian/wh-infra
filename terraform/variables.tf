variable "region" {
  default = "us-east-1"
}
variable "tfstate_bucket" {}
variable "env" {
  default = "test"
}
variable "function_name_get" {
  default = "GetWhitepapers-test"
}
variable "function_name_update" {
  default = "UpdateWhitepapers-test"
}
variable "env_subdomain_dnsname" {
  default = "dev.test.example.com"
}

variable "lambda_bucket" {}

variable "lambda_pkg_key" {}