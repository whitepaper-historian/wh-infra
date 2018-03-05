resource "aws_api_gateway_resource" "getwhitepapers_api_resource" {
  rest_api_id = "${data.terraform_remote_state.r.api_id}"
  parent_id   = "${data.terraform_remote_state.r.root_resource_id}"
  path_part   = "getwhitepapers"
}

resource "aws_api_gateway_method" "getwhitepapers_get_method" {
  rest_api_id   = "${data.terraform_remote_state.r.api_id}"
  resource_id   = "${aws_api_gateway_resource.getwhitepapers_api_resource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = "${data.terraform_remote_state.r.api_id}"
  resource_id             = "${aws_api_gateway_resource.getwhitepapers_api_resource.id}"
  http_method             = "${aws_api_gateway_method.getwhitepapers_get_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.getwhitepapers.arn}/invocations"
}

resource "aws_api_gateway_method_response" "getwhitepapers_return_200" {
  rest_api_id = "${data.terraform_remote_state.r.api_id}"
  resource_id = "${aws_api_gateway_resource.getwhitepapers_api_resource.id}"
  http_method = "${aws_api_gateway_method.getwhitepapers_get_method.http_method}"
  status_code = "200"

  response_models = {
         "application/json" = "Empty"
    }
}

resource "aws_api_gateway_integration_response" "getwhitepapers_response" {
  depends_on = ["aws_api_gateway_integration.integration"]
  
  rest_api_id = "${data.terraform_remote_state.r.api_id}"
  resource_id = "${aws_api_gateway_resource.getwhitepapers_api_resource.id}"
  http_method = "${aws_api_gateway_method.getwhitepapers_get_method.http_method}"
  status_code = "${aws_api_gateway_method_response.getwhitepapers_return_200.status_code}"

  response_templates = {
      "application/json" = ""
  } 
}

resource "aws_api_gateway_deployment" "getwhitepapers_deployment" {
  depends_on = ["aws_api_gateway_integration.integration"]

  rest_api_id = "${data.terraform_remote_state.r.api_id}"
  stage_name  = "${var.env}"
}