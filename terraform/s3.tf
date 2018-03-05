resource "aws_s3_bucket" "bucket" {
  bucket = "${var.env_subdomain_dnsname}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}