/*----------------------Task executoin rule--------------------*/
resource "aws_iam_role" "task_execution_role" {
  name = "${module.global_var.prefix}-task-execution-role"

  assume_role_policy = <<ROLEPOLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
ROLEPOLICY
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = "${aws_iam_role.task_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
/*-------------------------------------------------------------*/

resource "aws_iam_role" "task_role" {
  name = "${module.global_var.prefix}-task-role"

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