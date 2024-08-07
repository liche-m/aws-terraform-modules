resource "aws_iam_role" "eventbridge_role" {

  count = var.enabled && length(var.task_definitions) != 0 ? 1 : 0

  name = "${var.app_name}-eventbridge-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "events.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    {
      Name = "${var.app_name}-eventbridge-role"
    },
    var.tags
  )

}

data "aws_iam_policy_document" "this" {

  count = var.enabled && length(var.task_definitions) != 0 ? 1 : 0

  statement {
    sid = "AllowEventBridgeToCallPassRoleAPI"

    actions = [
      "iam:PassRole"
    ]

    resources = ["*"]
  }

}

resource "aws_iam_policy" "this" {

  count = var.enabled && length(var.task_definitions) != 0 ? 1 : 0

  name   = "IAMPassRolePermissions"
  path   = "/"
  policy = data.aws_iam_policy_document.this[0].json

}

resource "aws_iam_role_policy_attachment" "policy_1" {

  count = var.enabled && length(var.task_definitions) != 0 ? 1 : 0

  role       = aws_iam_role.eventbridge_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"

}

resource "aws_iam_role_policy_attachment" "policy_2" {

  count = var.enabled && length(var.task_definitions) != 0 ? 1 : 0

  role       = aws_iam_role.eventbridge_role[0].name
  policy_arn = aws_iam_policy.this[0].arn

}