resource "aws_route53_record" "env_subdomain" {
  zone_id = "${data.terraform_remote_state.r.zone_id}"
  name    = "${var.env_subdomain_dnsname}"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.bucket.website_endpoint}"
    zone_id                = "${aws_s3_bucket.bucket.hosted_zone_id}"
    evaluate_target_health = false
  }
}