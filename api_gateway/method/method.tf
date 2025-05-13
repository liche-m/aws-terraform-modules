resource "aws_api_gateway_method" "this" {
  count                = var.enabled ? 1 : 0
  rest_api_id          = var.rest_api_id
  resource_id          = var.resource_id
  http_method          = var.http_method
  authorization        = var.authorization
  authorizer_id        = var.authorizer_id
  api_key_required     = var.api_key_required
  request_validator_id = var.request_validator_id
  request_parameters   = var.request_parameters
  request_models       = var.request_content_type != null ? { "${var.request_content_type}" = var.request_model_name } : {}
}

resource "aws_api_gateway_method_response" "this" {
  count               = var.enabled ? 1 : 0
  rest_api_id         = var.rest_api_id
  resource_id         = var.resource_id
  http_method         = var.http_method
  status_code         = var.status_code
  response_parameters = var.response_parameters
  response_models     = var.response_content_type != null ? { "${var.response_content_type}" = var.response_model_name } : {}
}
