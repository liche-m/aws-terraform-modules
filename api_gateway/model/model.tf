resource "aws_api_gateway_model" "this" {
  count        = var.enabled ? 1 : 0
  rest_api_id  = var.rest_api_id
  name         = var.model_name
  description  = var.model_description
  content_type = var.content_type
  schema       = var.model_schema
}

output "model_id" {
  value       = try(aws_api_gateway_model.this[0].id, "none")
  description = "The ID of the Model."
}

output "model_name" {
  value       = try(aws_api_gateway_model.this[0].name, "none")
  description = "The name of the Model."
}
