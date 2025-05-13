resource "aws_api_gateway_api_key" "this" {
  count       = var.enabled ? 1 : 0
  name        = var.api_key_name
  description = var.api_key_description
  enabled     = var.api_key_enabled
  value       = var.api_key_value
  tags        = var.api_key_tags
}

resource "aws_api_gateway_usage_plan" "this" {
  count       = var.enabled ? 1 : 0
  name        = var.usage_plan_name
  description = var.usage_plan_description
  tags        = var.usage_plan_tags

  api_stages {
    api_id = var.rest_api_id
    stage  = var.stage_name

    throttle {
      path        = var.usage_plan_throttle_path
      burst_limit = var.usage_plan_burst
      rate_limit  = var.usage_plan_rate
    }
  }

  quota_settings {
    limit  = var.limit
    offset = var.offset
    period = var.period
  }

  throttle_settings {
    burst_limit = var.burst_limit
    rate_limit  = var.rate_limit
  }
}

resource "aws_api_gateway_usage_plan_key" "this" {
  count         = var.enabled ? 1 : 0
  key_id        = aws_api_gateway_api_key.this[0].id
  key_type      = var.api_key_type
  usage_plan_id = aws_api_gateway_usage_plan.this[0].id
}
