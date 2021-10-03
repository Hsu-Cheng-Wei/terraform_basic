resource "aws_s3_bucket" "bucket" {
  bucket = module.global_var.s3.bucket_name
  acl = "private"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "media" {
  for_each = { for i, v in module.global_var.s3.bucket_directory: i => v}
  bucket = aws_s3_bucket.bucket.id
  key = each.value
  source = ""
}

resource "aws_iam_role" "allow" {
  name = "${module.global_var.prefix}-s3-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY  
}