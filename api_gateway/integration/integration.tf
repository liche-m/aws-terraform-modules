resource "aws_api_gateway_integration" "this" {
  count                   = var.enabled ? 1 : 0
  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = var.http_method
  integration_http_method = var.integration_http_method
  type                    = var.type
  connection_type         = var.connection_type
  connection_id           = var.connection_id
  uri                     = var.integration_uri
  credentials             = var.credentials
  passthrough_behavior    = var.passthrough_behaviour
  content_handling        = var.req_content_handling
  timeout_milliseconds    = var.timeout_milliseconds
  request_templates       = var.request_templates
  request_parameters      = var.request_parameters
  cache_namespace         = var.cache_namespace
  cache_key_parameters    = var.cache_key_parameters

  tls_config {
    insecure_skip_verification = var.skip_cert_verification
  }
}

resource "aws_api_gateway_integration_response" "this" {
  count               = var.enabled ? 1 : 0
  rest_api_id         = var.rest_api_id
  resource_id         = var.resource_id
  http_method         = var.http_method
  status_code         = var.status_code
  content_handling    = var.resp_content_handling
  response_templates  = var.response_templates
  response_parameters = var.response_parameters
  selection_pattern   = var.selection_pattern
}
