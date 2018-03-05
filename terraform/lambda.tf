resource "aws_lambda_function" "getwhitepapers" {
  function_name = "${var.function_name_get}"
  s3_bucket = "${var.lambda_bucket}"
  s3_key = "${var.lambda_pkg_key}"
  handler = "index.handler"
  runtime = "nodejs6.10"
  role = "${aws_iam_role.iam_role_lambda.arn}"
}

resource "aws_lambda_function" "updatewhitepapers" {
  function_name = "${var.function_name_update}"
  s3_bucket = "${var.lambda_bucket}"
  s3_key = "${var.lambda_pkg_key}"
  handler = "index.handler"
  runtime = "nodejs6.10"
  timeout = "40"
  memory_size = "192"
  role = "${aws_iam_role.iam_role_lambda.arn}"
}