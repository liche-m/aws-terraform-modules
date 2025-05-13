resource "aws_cloudwatch_event_rule" "this" {

  count = var.enabled ? 1 : 0

  name           = "${var.app_name}-rule"
  description    = var.description
  event_bus_name = var.event_bus

  # Conditionally set "schedule_expression" or "event_pattern".
  schedule_expression = var.schedule_expression != "" ? var.schedule_expression : null
  event_pattern       = var.schedule_expression == "" ? var.event_pattern : null

  tags = merge(
    {
      Name = "${var.app_name}-rule"
    },
    var.tags
  )
}

# Lambda Functions as targets
resource "aws_cloudwatch_event_target" "lambda" {

  count = var.enabled && length(var.lambda_target) != 0 ? length(var.lambda_target) : 0

  arn       = var.lambda_target[count.index]
  rule      = "${var.app_name}-rule"
  target_id = var.target_id

  depends_on = [
    aws_cloudwatch_event_rule.this
  ]

}

# SNS Topics as targets
resource "aws_cloudwatch_event_target" "sns" {

  count = var.enabled && length(var.sns_target) != 0 ? length(var.sns_target) : 0

  arn       = var.sns_target[count.index]
  rule      = "${var.app_name}-rule"
  target_id = var.target_id

  depends_on = [
    aws_cloudwatch_event_rule.this
  ]

}

# SQS Queues as targets
resource "aws_cloudwatch_event_target" "sqs" {

  for_each = var.enabled && length(var.sqs_target) > 0 ? var.sqs_target : {}

  arn       = each.value.arn
  rule      = "${var.app_name}-rule"
  target_id = var.target_id

  dynamic "sqs_target" {
    for_each = each.value.message_group_id != null ? [1] : []

    content {
      message_group_id = each.value.message_group_id
    }

  }

  depends_on = [
    aws_cloudwatch_event_rule.this
  ]

}

# Lambda Resource-Based Policy
resource "aws_lambda_permission" "lambda_policy" {

  count = var.enabled && length(var.lambda_target) != 0 ? length(var.lambda_target) : 0

  statement_id  = "AllowEventBridgeToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_target[count.index]
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this[0].arn

}

# ECS Task Definitions as targets
resource "aws_cloudwatch_event_target" "ecs" {

  count = var.enabled && length(var.task_definitions) != 0 ? length(var.task_definitions) : 0

  arn       = var.ecs_clusters[count.index]
  rule      = "${var.app_name}-rule"
  target_id = var.target_id
  role_arn  = aws_iam_role.eventbridge_role[0].arn

  ecs_target {

    task_definition_arn     = var.task_definitions[count.index]
    enable_ecs_managed_tags = try(var.enable_ecs_managed_tags[count.index], false)
    enable_execute_command  = try(var.enable_execute_command[count.index], false)
    launch_type             = length(var.launch_types) > 0 ? var.launch_types[count.index] : null

    dynamic "capacity_provider_strategy" {

      for_each = {
        for k, v in try(var.capacity_provider_strategies[count.index], []) :
        k => v
        if var.set_provider_strategy[count.index] &&
        try(var.launch_types[count.index], null) == null
      }

      content {
        base              = try(capacity_provider_strategy.value.base, null)
        capacity_provider = try(capacity_provider_strategy.value.capacity_provider)
        weight            = try(capacity_provider_strategy.value.weight, null)
      }

    }

    network_configuration {
      subnets          = var.network_configurations[count.index].subnets
      security_groups  = var.network_configurations[count.index].security_groups
      assign_public_ip = var.network_configurations[count.index].assign_public_ip
    }

    platform_version = try(var.platform_versions[count.index], null)
    propagate_tags   = try(var.propagate_tags[count.index], "TASK_DEFINITION")
    task_count       = try(var.task_counts[count.index], 1)
    tags             = try(var.ecs_tags[count.index], {})
  }

  depends_on = [
    aws_iam_role.eventbridge_role
  ]

}
