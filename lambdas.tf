resource "aws_lambda_function" "sendemail" {
  function_name = "SendEmail"
  role          = aws_iam_role.lambda_role.arn
  handler       = "aws.lambda.example::aws.lambda.example.EmailService::SendEmail"
  runtime       = "dotnetcore3.1"
  memory_size   = 256
  timeout       = 30
  publish       = true
  filename      = "./src/lambda-send-email.zip"
  depends_on    = [
    aws_iam_role.lambda_role,
  ]
}

resource "aws_iam_role" "lambda_role" {
    name = "${local.prefix}-lambda-role"

    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "",
                "Action": "sts:AssumeRole"    
                "Effect": "Allow",
                "Principal": {
                    "Service": "lambda.amazonaws.com"
                },
            }
        ]
    })

    inline_policy {
        name = "${local.prefix}-lambda-role-policy"
        policy = jsonencode({
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": "ses:SendEmail",
                    "Resource": "*"
                },
              ]
        })
    }
}