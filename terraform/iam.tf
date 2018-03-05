resource "aws_iam_role" "iam_role_lambda" {
  name = "iam_role_lambda"
  path = "/wh/${var.env}/"
  description = "Role for Lambda components of Whitepaper Historian"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {

      "Sid": "GrantLambdaAssumeRights",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_policy" {
  name        = "LambdaDBAccessPolicy"
  role = "${aws_iam_role.iam_role_lambda.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Sid": "DynamoDBAccess",
      "Effect": "Allow",
      "Action": [
        "dynamodb:*"
      ],
      "Resource": [
        "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/whitepapers-${var.env}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "managed_role_attach" {
    role       = "${aws_iam_role.iam_role_lambda.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole"
}

resource "aws_iam_role" "iam_role_dyndb_autoscale" {
  name = "iam_role_dyndb_autoscale"
  path = "/wh/${var.env}/"
  description = "Role for Lambda components of Whitepaper Historian"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {

      "Sid": "GrantAppAutoScalingAssumeRights",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "dynamodb_policy" {
  name        = "DynamoDBAutoscalePolicy"
  role        = "${aws_iam_role.iam_role_dyndb_autoscale.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DynamoDBScalingPolicy",
      "Effect": "Allow",
      "Action": [
        "dynamodb:DescribeTable",
        "dynamodb:UpdateTable",
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:SetAlarmState",
        "cloudwatch:DeleteAlarms"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}