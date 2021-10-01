resource "aws_lambda_function" "sendemail" {
  function_name = "SendEmail"
  role          = aws_iam_role.lambda_role.arn
  handler       = "Pumpkin.VR_CMS.SendEmail.Lambda::Pumpkin.VR_CMS.SendEmail.Lambda.Function::Handler"
  runtime       = "dotnetcore3.1"
  memory_size   = 256
  timeout       = 30
  publish       = true
  filename      = "./src/out/Pumpkin.VR_CMS.SendEmail.Lambda.zip"
  depends_on    = [
    aws_iam_role.lambda_role,
  ]
}

resource "aws_lambda_function" "media_convert" {
  function_name = "MediaConvert"
  role          = aws_iam_role.lambda_role.arn
  handler       = "Pumpkin.VR_CMS.MediaConvert.Lambda::Pumpkin.VR_CMS.MediaConvert.Lambda.Function::Handler"
  runtime       = "dotnetcore3.1"
  memory_size   = 256
  timeout       = 30
  publish       = true
  filename      = "./src/out/Pumpkin.VR_CMS.MediaConvert.Lambda.zip"
  depends_on    = [
    aws_iam_role.lambda_role,
  ]
}

resource "aws_lambda_function" "cloudwatch_media_convert" {
  function_name = "CloudWatchMediaConvert"
  role          = aws_iam_role.lambda_role.arn
  handler       = "Pumpkin.VR_CMS.CloudWatch.MediaConvert.Lambda::Pumpkin.VR_CMS.CloudWatch.MediaConvert.Lambda.Function::Handler"
  runtime       = "dotnetcore3.1"
  memory_size   = 256
  timeout       = 30
  publish       = true
  filename      = "./src/out/Pumpkin.VR_CMS.CloudWatch.MediaConvert.Lambda.zip"
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
                    "Action":[
                        "logs:CreateLogGroup",
                        "logs:CreateLogStream",
                        "logs:PutLogEvents",
                        "logs:DescribeLogGroups",

                        "ses:SendEmail",

                        "mediaconvert:CreateJob",
                        "iam:PassRole"
                    ],
                    "Effect": "Allow",
                    "Resource": "*"
                },
              ]
        })
    }
}