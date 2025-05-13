resource "aws_api_gateway_stage" "this" {
  count                 = var.enabled ? 1 : 0
  stage_name            = var.stage_name
  deployment_id         = var.deployment_id
  rest_api_id           = var.rest_api_id
  description           = var.stage_description
  variables             = var.stage_variables
  cache_cluster_enabled = var.cache_cluster_enabled
  xray_tracing_enabled  = var.xray_tracing_enabled
  cache_cluster_size    = var.cache_cluster_size
  client_certificate_id = var.client_certificate_id
  documentation_version = var.documentation_version
}

output "stage_id" {
  value       = try(aws_api_gateway_stage.this[0].id, "none")
  description = "The ID of the Stage."
}

output "stage_name" {
  value       = try(aws_api_gateway_stage.this[0].stage_name, "none")
  description = "The name of the Stage."
}

output "execution_arn" {
  value       = try(aws_api_gateway_stage.this[0].execution_arn, "none")
  description = "The ARN that can be used in the Lambda Resource-Based policy."
}

#----------------------- Method Settings ------------------------#

resource "aws_api_gateway_method_settings" "this" {
  count       = var.enabled ? 1 : 0
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name
  method_path = var.method_path

  settings {
    logging_level          = var.logging_level
    metrics_enabled        = var.metrics_enabled
    data_trace_enabled     = var.data_trace_enabled
    throttling_burst_limit = var.burst_limit
    throttling_rate_limit  = var.rate_limit
  }
}
