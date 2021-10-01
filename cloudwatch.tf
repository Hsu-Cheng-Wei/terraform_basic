//https://registry.terraform.io/modules/terraform-aws-modules/eventbridge/aws/latest
module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false

  rules = {
    media-convert = {
      description   = "Capture media convert status changes"
      event_pattern = jsonencode(
{
  "source": ["aws.mediaconvert"],
  "detail-type": ["MediaConvert Job State Change"],
  "detail": {
    "status": ["COMPLETE", "ERROR"]
  }
})
      enabled       = true
    }
  }

  targets = {
      media-convert = [
          {
              name = "media-convert"
              arn  = aws_lambda_function.cloudwatch_media_convert.arn
          }
      ]
  }

  tags = {
    Name = "${local.prefix}-detect-media-convert"
  }

  depends_on = [
    aws_lambda_function.cloudwatch_media_convert
  ]
}