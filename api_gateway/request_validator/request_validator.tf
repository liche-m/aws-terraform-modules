resource "aws_api_gateway_request_validator" "this" {
  count                       = var.enabled ? 1 : 0
  name                        = var.request_validator_name
  rest_api_id                 = var.rest_api_id
  validate_request_body       = var.validate_request_body
  validate_request_parameters = var.validate_request_parameters
}

output "request_validator_id" {
  value       = try(aws_api_gateway_request_validator.this[0].id, "none")
  description = "The ID of the Request Validator."
}
