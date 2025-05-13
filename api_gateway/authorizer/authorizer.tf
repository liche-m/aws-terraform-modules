resource "aws_api_gateway_authorizer" "this" {
  count                            = var.enabled ? 1 : 0
  name                             = var.authorizer_name
  type                             = var.authorizer_type
  rest_api_id                      = var.rest_api_id
  authorizer_uri                   = var.authorizer_uri
  authorizer_credentials           = var.iam_role
  authorizer_result_ttl_in_seconds = var.authorizer_result_ttl
  identity_source                  = var.identity_sources
}

output "authorizer_id" {
  value       = try(aws_api_gateway_authorizer.this[0].id, "none")
  description = "The ID of the API Gateway Authorizer."
}
