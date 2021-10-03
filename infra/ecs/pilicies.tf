/*---------------Task S3 role policy--------------*/
resource "aws_iam_policy" "task_policy" {
    name = "${module.global_var.prefix}-task-policy"
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": [
            "s3:GetObject",
            "s3:GetObjectVersion"
            "s3:PutObject"
        ],
        "Effect": "Allow",
        "Resource": [
            "${aws_s3_bucket.source.arn}"
        ]
        },        
    ]
}
POLICY
}