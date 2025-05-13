#---------------------- Custom Domain Name ----------------------#

resource "aws_api_gateway_domain_name" "this" {
  count                    = var.enabled ? 1 : 0
  domain_name              = var.domain_name
  regional_certificate_arn = var.certificate_arn
  security_policy          = var.security_policy
  tags                     = var.tags

  endpoint_configuration {
    types = [var.endpoint]
  }
}

#---------------------- Base Path Mapping -----------------------#

resource "aws_api_gateway_base_path_mapping" "this" {
  count       = var.enabled ? 1 : 0
  api_id      = var.rest_api_id
  stage_name  = var.stage_name
  domain_name = var.domain_name
}
