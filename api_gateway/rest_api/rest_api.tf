#--------------------------- REST API ---------------------------#

resource "aws_api_gateway_rest_api" "this" {
  count                        = var.enabled ? 1 : 0
  name                         = var.rest_api_name
  description                  = var.rest_api_description
  disable_execute_api_endpoint = var.disable_default_api_endpoint
  api_key_source               = var.api_key_source
  binary_media_types           = var.binary_media_types

  endpoint_configuration {
    types = [var.api_endpoint_type]
  }
}

output "rest_api_id" {
  value       = try(aws_api_gateway_rest_api.this[0].id, "none")
  description = "The ID of the REST API."
}

output "root_resource_id" {
  value       = try(aws_api_gateway_rest_api.this[0].root_resource_id, "none")
  description = "The resource ID of the REST API's root."
}

#--------------------- API Gateway Account ----------------------#

resource "aws_api_gateway_account" "this" {
  count               = var.enabled ? 1 : 0
  cloudwatch_role_arn = var.cloudwatch_role_arn
}

#-------------------------- Deployment --------------------------#

resource "aws_api_gateway_deployment" "this" {
  count       = var.enabled ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this[0].id
  description = var.deployment_description

  triggers = {
    redeployment = sha1(jsonencode(var.deployment_resources))
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "deployment_id" {
  value       = try(aws_api_gateway_deployment.this[0].id, "none")
  description = "The ID of the API Gateway deployment."
}

#-------------------- Resource-Based Policy ---------------------#

resource "aws_api_gateway_rest_api_policy" "this" {
  count       = var.enabled && var.create_policy ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this[0].id
  policy      = var.policy
}
