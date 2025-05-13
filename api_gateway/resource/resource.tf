resource "aws_api_gateway_resource" "this" {
  count       = var.enabled ? 1 : 0
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = var.path_part
}

output "resource_id" {
  value       = try(aws_api_gateway_resource.this[0].id, "none")
  description = "The ID of the API resource."
}

output "resource_path" {
  value       = try(aws_api_gateway_resource.this[0].path, "none")
  description = "The complete path for this API resource (including all parent paths)."
}
